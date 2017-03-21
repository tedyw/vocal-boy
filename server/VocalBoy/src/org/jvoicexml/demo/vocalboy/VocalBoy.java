/*
 * File:    $HeadURL: https://svn.sourceforge.net/svnroot/jvoicexml/trunk/demo/HelloWorldDemo/src/org/jvoicexml/demo/helloworlddemo/HelloWorldDemo.java $
 * Version: $LastChangedRevision: 239 $
 * Date:    $Date: 2007-02-27 14:41:25 +0100 (Di, 27 Feb 2007) $
 * Author:  $LastChangedBy: schnelle $
 *
 * JVoiceXML Demo - Demo for the free VoiceXML implementation JVoiceXML
 *
 * Copyright (C) 2005-2007 JVoiceXML group - http://jvoicexml.sourceforge.net
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 */

package org.jvoicexml.demo.vocalboy;

import java.io.IOException;
import java.net.URI;
import java.io.File;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.jvoicexml.JVoiceXml;
import org.jvoicexml.Session;
import org.jvoicexml.documentserver.schemestrategy.MappedDocumentRepository;
import org.jvoicexml.event.JVoiceXMLEvent;
import org.jvoicexml.xml.vxml.Block;
import org.jvoicexml.xml.vxml.Form;
import org.jvoicexml.xml.vxml.Goto;
import org.jvoicexml.xml.vxml.Meta;
import org.jvoicexml.xml.vxml.Prompt;
import org.jvoicexml.xml.vxml.VoiceXmlDocument;
import org.jvoicexml.xml.vxml.Vxml;
import org.jvoicexml.client.GenericClient;

/**
 * Demo implementation of the venerable "Hello World".
 *
 * @author Dirk Schnelle
 * @version $Revision: 239 $
 *          <p>
 *          <p>
 *          Copyright &copy; 2005-2007 JVoiceXML group -
 *          <a href="http://jvoicexml.sourceforge.net">
 *          http://jvoicexml.sourceforge.net/</a>
 *          </p>
 */
public final class VocalBoy {
    /**
     * Logger for this class.
     */
    private static final Logger LOGGER =
            Logger.getLogger(VocalBoy.class);

    /**
     * The JNDI context.
     */
    private Context context;

    /**
     * Do not create from outside.
     */
    private VocalBoy() {
        try {
            context = new InitialContext();
        } catch (javax.naming.NamingException ne) {
            LOGGER.error("error creating initial context", ne);

            context = null;
        }
    }

    /**
     * Calls the VoiceXML interpreter context to process the given XML document.
     *
     * @param uri URI of the first document to load
     * @throws JVoiceXMLEvent Error processing the call.
     */
    private void interpretDocument(final URI uri)
            throws JVoiceXMLEvent {
        JVoiceXml jvxml;
        try {
            jvxml = (JVoiceXml) context.lookup("JVoiceXml");
        } catch (javax.naming.NamingException ne) {
            LOGGER.error("error obtaining JVoiceXml", ne);

            return;
        }

        final Session session = jvxml.createSession(null);

        session.call(uri);
        session.waitSessionEnd();
        session.close();
    }

    /**
     * The main method.
     *
     * @param args Command line arguments. None expected.
     */
    public static void main(final String[] args) {

        // Bypass security policy
        System.setProperty("java.security.policy", "./config/jvoicexml.policy");

        if (LOGGER.isInfoEnabled()) {
            LOGGER.info("Starting VocalBoy for JVoiceXML...");
        }

        final VocalBoy demo = new VocalBoy();

        final GenericClient client = new GenericClient();
        final URI uri;

        try {
            uri = new URI("http://localhost:4001/VocalBoy/vocalboydialog.vxml");
            LOGGER.info(uri);

            try {
                demo.interpretDocument(uri);
            } catch (org.jvoicexml.event.JVoiceXMLEvent e) {
                LOGGER.error("error processing the document", e);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.exit(-1);
        }


    }
}
