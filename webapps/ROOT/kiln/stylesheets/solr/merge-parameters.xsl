<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- This XSLT adds the Solr query parameters passed in the
       query-string parameter to an XML query document (root element
       "query"). The document is only added to, with the new elements
       added after the existing ones. -->

  <xsl:param name="query-string" />

  <xsl:template match="query">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
      <xsl:for-each select="tokenize($query-string, '&amp;')">
        <xsl:element name="{substring-before(., '=')}">
          <xsl:value-of select="substring-after(., '=')" />
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>