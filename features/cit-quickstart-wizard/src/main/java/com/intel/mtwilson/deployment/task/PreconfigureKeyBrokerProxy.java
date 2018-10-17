/*
 * Copyright (C) 2015 Intel Corporation
 * All rights reserved.
 */
package com.intel.mtwilson.deployment.task;

import com.intel.mtwilson.deployment.FileTransferDescriptor;
import com.intel.mtwilson.deployment.FileTransferManifestProvider;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * Generates kmsproxy.env using a template. 
 * 
 * @author jbuhacoff
 */
public class PreconfigureKeyBrokerProxy extends AbstractPreconfigureTask implements FileTransferManifestProvider {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(PreconfigureKeyBrokerProxy.class);
    private List<FileTransferDescriptor> manifest;
    private File envFile;
    
    /**
     * Initializes the task with a file transfer manifest; the file(s) mentioned
     * in the manifest will not be available until AFTER execute() completes
     * successfully.
     */
    public PreconfigureKeyBrokerProxy() {
        super(); // initializes taskDirectory
        envFile = getTaskDirectory().toPath().resolve("kmsproxy.env").toFile();
        manifest = new ArrayList<>();
        manifest.add(new FileTransferDescriptor(envFile, envFile.getName()));
    }
    
    @Override
    public void execute() {
        // preconditions:  
        // MTWILSON_HOST, MTWILSON_PORT, and MTWILSON_TLS_CERT_SHA256 must be set ;  note that if using a load balanced mtwilson, the tls cert is for the load balancer
        // the host and port are set by PreconfigureAttestationService, but the tls sha256 fingerprint is set by PostconfigureAttestationService.
        // either way, the sync task forces all attestation service tasks to complete before key broker proxy tasks start, so these settings should be present.
        if( setting("mtwilson.host").isEmpty() || setting("mtwilson.port.https").isEmpty() || setting("mtwilson.tls.cert.sha256").isEmpty() ) {
            throw new IllegalStateException("Missing required settings"); // TODO:  rewrite as a precondition
        }

        setting("kmsproxy.host", target.getHost());
        
        // key broker proxy settings
        port();
        data.put("JETTY_PORT", setting("kmsproxy.port.http"));
        data.put("JETTY_SECURE_PORT", setting("kmsproxy.port.https"));
        
        // the PreconfigureAttestationService task must already be executed 
        data.put("MTWILSON_HOST", setting("mtwilson.host"));
        data.put("MTWILSON_PORT", setting("mtwilson.port.https"));
        // the PostconfigureAttestationService task must already be executed 
        data.put("MTWILSON_TLS_CERT_SHA256", setting("mtwilson.tls.cert.sha256"));
        // generate the .env file using pre-configuration data
        render("kmsproxy.env.st4", envFile);
    }

    private void port() {
        // if the target has more than one software package to be installed on it,
        // use our alternate port
        if (setting("kmsproxy.port.http").isEmpty() || setting("kmsproxy.port.https").isEmpty()) {
            if (target.getPackages().size() == 1) {
                setting("kmsproxy.port.http", "80");
                setting("kmsproxy.port.https", "443");
            } else {
                setting("kmsproxy.port.http", "21080");
                setting("kmsproxy.port.https", "21443");
            }
        }
    }


    @Override
    public String getPackageName() {
        return "key_broker_proxy";
    }

    /**
     * Must be called AFTER execute() to get list of files that should be
     * transferred to the remote host
     * @return 
     */
    @Override
    public List<FileTransferDescriptor> getFileTransferManifest() {
        return manifest;
    }

    
}
