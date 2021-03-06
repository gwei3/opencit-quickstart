/*
 * Copyright (C) 2015 Intel Corporation
 * All rights reserved.
 */
package com.intel.mtwilson.util.task;

import java.util.Collection;

/**
 *
 * @author jbuhacoff
 */
public interface Dependencies<T extends Dependencies> {
    Collection<T> getDependencies();
}
