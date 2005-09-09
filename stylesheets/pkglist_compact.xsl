<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" omit-xml-declaration="yes" indent="yes"/>
 
  <!-- A variable to store the base address of the repository -->
  <xsl:param name="base_address">http://localhost/debian/</xsl:param>
 
  <xsl:template match="packages">
    <div class="pkglist">
      <h2>Package list</h2>
      <table>
      <thead>
        <tr><td>Name</td><td>Architecture</td><td>Maintainer</td></tr>
      </thead>
      <xsl:apply-templates select="package"/>
      </table>
    </div>
  </xsl:template>

  <!-- Handle the "package" element -->
  <xsl:template match="package">
      <tr>
        <td>
          <xsl:value-of select="name/text()"/>
          (<a href="{$base_address}{filename/text()}"><xsl:value-of select="version/text()"/></a>)
        </td>
        <td>
          <xsl:value-of select="architecture/text()"/>
        </td>
        <td>
          <xsl:apply-templates select="maintainer"/>
        </td>
      </tr>
    
  </xsl:template>
 
  <xsl:template match="maintainer">
    <a href="mailto:{contact/email/text()}"><xsl:value-of select="contact/name/text()"/></a>
  </xsl:template>
  
</xsl:stylesheet>
