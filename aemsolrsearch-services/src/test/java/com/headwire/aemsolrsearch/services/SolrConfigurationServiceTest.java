package com.headwire.aemsolrsearch.services;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

/**
 * TODO: Add class javadoc
 * User: snoctl
 * Date: 4/11/2016
 * Time: 3:44 PM
 * To change this template use File | Settings | File Templates.
 */
public class SolrConfigurationServiceTest {
    SolrConfigurationService config;
    @Before
    public void setUp() throws Exception {

        config = new SolrConfigurationService();



    }

    @Test
    public void getSolrEndPoint() throws Exception {
        String endpoint = config.getSolrEndPoint();
        Assert.assertNotNull(endpoint);

    }

    @Test
    public void getProxyUrl() throws Exception {

    }

    @Test
    public void isProxyEnabled() throws Exception {

    }

    @Test
    public void getCores() throws Exception {

    }

    @Test
    public void fetchCollectionShards() throws Exception {

    }

    @Test
    public void getStoredFields() throws Exception {

    }

    @Test
    public void getIndexedFields() throws Exception {

    }

    @Test
    public void getIndexedFieldsFromLuke() throws Exception {

    }

    @Test
    public void isRequestHandlerAllowed() throws Exception {

    }

    @Test
    public void activate() throws Exception {

    }

    @Test
    public void modified() throws Exception {

    }

    @Test
    public void getIndexingSolrClient() throws Exception {

    }

    @Test
    public void getQueryingSolrClient() throws Exception {

    }

    @Test
    public void isCloudMode() throws Exception {

    }

    @Test
    public void isStandaloneMode() throws Exception {

    }

    @Test
    public void clearSolrClient() throws Exception {

    }

}