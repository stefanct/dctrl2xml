<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
 
  <!-- A variable to store the base address of the repository -->
  <xsl:param name="base_address">http://localhost/debian/</xsl:param>
 
  <xsl:template match="packages">
    <div class="pkglist">
      <h2>Package list</h2>
      <xsl:apply-templates select="package"/>
    </div>
    <br/>
  </xsl:template>

  <!-- Handle the "package" element -->
  <xsl:template match="package">
    <div class="package">
      <h3><xsl:value-of select="name/text()"/> (<xsl:value-of select="version/text()"/>)</h3>
      <h4><xsl:value-of select="description/text()"/></h4>
      <pre>
      <xsl:value-of select="long-description/text()"/>
      </pre>
      <p>
      <b>Architecture</b>: <xsl:value-of select="architecture/text()"/> 
      (<a href="{$base_address}{filename/text()}">Download</a>)<br/>
      <xsl:apply-templates select="maintainer"/>
      </p>
    </div>
  </xsl:template>
 
  <xsl:template match="maintainer">
    <b>Maintainer</b>:
    <xsl:value-of select="contact/name/text()"/>
    &lt;<xsl:apply-templates select="contact/email"/>&gt;<br/>
  </xsl:template>
  
  <xsl:template match="email">
    <a href="mailto:{text()}"><tt>
      <xsl:value-of select="text()"/>
    </tt></a>
  </xsl:template> 

</xsl:stylesheet>
