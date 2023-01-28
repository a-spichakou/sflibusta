<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:l="http://www.w3.org/1999/xlink"
                xmlns:f="http://www.gribuser.ru/xml/fictionbook/2.0" xmlns:xls="http://www.w3.org/1999/XSL/Transform" >

    <xls:param name="archivename"/>
    <xls:param name="filename"/>
    <xsl:template match="/f:FictionBook">        
        <add>
            <doc>
                <xsl:for-each select="f:description">
                    <xsl:for-each select="f:title-info/f:genre">
                        <field name="genre">
                            <xsl:value-of select="."/>
                        </field>
                    </xsl:for-each>
                    <field name="archivename">
                        <xsl:copy-of select="$archivename"/>
                    </field>
                    <field name="filename">
                        <xsl:value-of select="$filename"/>
                    </field>
                    <field name="date">
                        <xsl:value-of select="f:title-info/f:date"/>
                    </field>
                    <field name="author-first-name">
                        <xsl:value-of select="f:title-info/f:author/f:first-name"/>
                    </field>
                    <field name="author-middle-name">
                        <xsl:value-of select="f:title-info/f:author/f:middle-name"/>
                    </field>
                    <field name="author-last-name">
                        <xsl:value-of select="f:title-info/f:author/f:last-name"/>
                    </field>
                    <field name="author-id">
                        <xsl:value-of select=" f:title-info/f:author/f:id"/>
                    </field>
                    <field name="book-title">
                        <xsl:value-of select="f:title-info/f:book-title"/>
                    </field>
                    <field name="annotation">
                        <xsl:value-of select="translate(normalize-space(f:title-info/f:annotation), '&#xA;', '')"/>
                    </field>
                    <field name="lang">
                        <xsl:value-of select="f:title-info/f:lang"/>
                    </field>
                    <field name="src-lang">
                        <xsl:value-of select="f:title-info/f:src-lang"/>
                    </field>
                    <field name="translator-first-name">
                        <xsl:value-of select="f:title-info/f:translator/f:first-name"/>
                    </field>
                    <field name="translator-last-name">
                        <xsl:value-of select="f:title-info/f:translator/f:last-name"/>
                    </field>
                    <field name="sequence">
                        <xsl:value-of select="f:title-info/f:sequence/@name"/>
                    </field>
                    <field name="document-first-name">
                        <xsl:value-of select="f:document-info/f:author/f:first-name"/>
                    </field>
                    <field name="document-middle-name">
                        <xsl:value-of select="f:document-info/f:author/f:middle-name"/>
                    </field>
                    <field name="document-last-name">
                        <xsl:value-of select="f:document-info/f:author/f:last-name"/>
                    </field>
                    <field name="document-program-used">
                        <xsl:value-of select="f:document-info/f:program-used"/>
                    </field>
                    <field name="document-date">
                        <xsl:value-of select="f:document-info/f:date/@value"/>
                    </field>
                    <field name="document-datetime">
                        <xsl:value-of select="f:document-info/f:date"/>
                    </field>
                    <field name="document-src-ocr">
                        <xsl:value-of select="f:document-info/f:src-ocr"/>
                    </field>
                    <field name="id">
                        <xsl:value-of select="$archivename"/>/<xsl:value-of select="$filename"/>/<xsl:value-of select="f:document-info/f:id"/>
                    </field>
                    <field name="document-id">
                        <xsl:value-of select="f:document-info/f:id"/>
                    </field>
                    <field name="document-version">
                        <xsl:value-of select="f:document-info/f:version"/>
                    </field>
                    <xsl:for-each select="f:document-info/f:history/f:p">
                        <field name="document-history">
                            <xsl:value-of select="normalize-space(.)"/>
                        </field>
                    </xsl:for-each>
                    <field name="document-author-nickname">
                        <xsl:value-of select="f:document-info/f:author/f:nickname"/>
                    </field>
                    <field name="document-author-email">
                        <xsl:value-of select="f:document-info/f:author/f:email"/>
                    </field>
                    <field name="document-author-home-page">
                        <xsl:value-of select="f:document-info/f:author/f:home-page"/>
                    </field>
                    <field name="publish-info-book-name">
                        <xsl:value-of select="f:publish-info/f:book-name"/>
                    </field>
                    <field name="publish-info-publisher">
                        <xsl:value-of select="f:publish-info/f:publisher"/>
                    </field>
                    <field name="publish-info-city">
                        <xsl:value-of select="f:publish-info/f:city"/>
                    </field>
                    <field name="publish-info-year">
                        <xsl:value-of select="f:publish-info/f:year"/>
                    </field>
                    <field name="publish-info-isbn">
                        <xsl:value-of select="f:publish-info/f:isbn"/>
                    </field>
                </xsl:for-each>
                <xsl:for-each select="f:body/f:title/f:p">
                    <field name="title">
                        <xsl:value-of select="normalize-space(.)"/>
                    </field>
                </xsl:for-each>

                <field name="content">
                    <xsl:for-each select="f:description">
                        <xsl:for-each select="f:title-info/f:genre">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                        |<xsl:value-of select="f:title-info/f:date"/>|<xsl:value-of
                            select="f:title-info/f:author/f:first-name"/>|<xsl:value-of
                            select="f:title-info/f:author/f:middle-name"/>|<xsl:value-of
                            select="f:title-info/f:author/f:last-name"/>|<xsl:value-of
                            select=" f:title-info/f:author/f:id"/>|<xsl:value-of select="f:title-info/f:book-title"/>|
                        <xsl:value-of
                                select="translate(normalize-space(f:title-info/f:annotation), '&#xA;', '')"/>|<xsl:value-of
                            select="f:title-info/f:lang"/>|<xsl:value-of select="f:title-info/f:src-lang"/>|
                        <xsl:value-of select="f:title-info/f:translator/f:first-name"/>|<xsl:value-of
                            select="f:title-info/f:translator/f:last-name"/>|<xsl:value-of
                            select="f:title-info/f:sequence/@name"/>|<xsl:value-of
                            select="f:document-info/f:author/f:first-name"/>|<xsl:value-of
                            select="f:document-info/f:author/f:middle-name"/>|<xsl:value-of
                            select="f:document-info/f:author/f:last-name"/>|<xsl:value-of
                            select="f:document-info/f:program-used"/>|<xsl:value-of
                            select="f:document-info/f:date/@value"/>|<xsl:value-of
                            select="f:document-info/f:date"/>|<xsl:value-of
                            select="f:document-info/f:src-ocr"/>|<xsl:value-of select="$archivename"/>/<xsl:value-of
                            select="$filename"/>/<xsl:value-of
                            select="f:document-info/f:id"/>|<xsl:value-of select="f:document-info/f:id"/>|<xsl:value-of
                            select="f:document-info/f:version"/>|
                        <xsl:for-each select="f:document-info/f:history/f:p">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:for-each>
                        <xsl:value-of select="f:document-info/f:author/f:nickname"/>|<xsl:value-of
                            select="f:document-info/f:author/f:email"/>|<xsl:value-of
                            select="f:document-info/f:author/f:home-page"/>|<xsl:value-of
                            select="f:publish-info/f:book-name"/>|<xsl:value-of
                            select="f:publish-info/f:publisher"/>|<xsl:value-of
                            select="f:publish-info/f:city"/>|<xsl:value-of select="f:publish-info/f:year"/>|<xsl:value-of
                            select="f:publish-info/f:isbn"/>
                    </xsl:for-each>
                    |
                    <xsl:for-each select="f:body/f:title/f:p">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:for-each>
                </field>
            </doc>
        </add>
    </xsl:template>

</xsl:stylesheet>
