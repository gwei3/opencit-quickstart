/*
 * Copyright (C) 2015 Intel Corporation
 * All rights reserved.
 */
package com.intel.mtwilson.deployment;

import com.intel.mtwilson.Folders;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 *
 * @author jbuhacoff
 */
public class FeatureRepositoryFactory {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(FeatureRepositoryFactory.class);
    private static final Object instanceLock = new Object();
    private static JsonFeatureRepository instance;
    
    /**
     * 
     * @param edition must be the name (without .json extension) of a file in the "cit-features" directory; currently one of "PRIVATE", "PROVIDER", or "SUBSCRIBER"
     * @return
     * @throws IOException 
     */
    public static FeatureRepository getInstance(String edition) throws IOException {
        SoftwarePackageRepository softwarePackageRepository = SoftwarePackageRepositoryFactory.getInstance();
        synchronized(instanceLock) {
            if( instance == null ) {
                File file = new File(Folders.repository("cit-features") + File.separator + edition + ".json");
                instance = new JsonFeatureRepository(new FileInputStream(file), softwarePackageRepository);
            }
        }
        return instance;
    }

    
}
