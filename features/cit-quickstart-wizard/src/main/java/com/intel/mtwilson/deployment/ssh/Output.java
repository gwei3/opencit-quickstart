/*
 * Copyright (C) 2015 Intel Corporation
 * All rights reserved.
 */
package com.intel.mtwilson.deployment.ssh;

import java.io.IOException;
import java.io.OutputStream;

/**
 *
 * @author jbuhacoff
 */
public interface Output {

    /**
     * 
     * @return a new output stream that MAY overwrite data stored by prior output streams
     * @throws IOException 
     */
    OutputStream getOutputStream() throws IOException;

    /**
     * 
     * @return a new error stream that MAY overwrite data stored by prior error streams
     * @throws IOException 
     */
    OutputStream getErrorStream() throws IOException;
    
}
