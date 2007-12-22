<?xml version="1.0" encoding="UTF-8"?>
<!--
  Here is an example how dctrl2xml and this stylesheet can be used to
  create a packages overview page from a repository's Packages file:

  dctrl2xml -f /var/lib/apt/lists/ftp.debian.org_debian_dists_sid_main_binary-i386_Packages > /tmp/packages.xml
  xsltproc -o /tmp/packages.html pkglist.xsl /tmp/packages.xml
-->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output
    method="xml"
    encoding="UTF-8"
    indent="yes"
    omit-xml-declaration="yes"/>

  <!-- The base address of the repository. It is used as prefix in URLs to
       the .deb packages, see the "package" template for details. -->
  <xsl:param name="base_address">http://ftp.debian.org/debian/</xsl:param>

  <xsl:template match="packages">
    <div class="pkglist">
      <h2>Package list</h2>
      <xsl:apply-templates select="package"/>
    </div>
    <br/>
  </xsl:template>

  <xsl:template match="package">
    <div class="package">
      <h3>
        <xsl:value-of select="name/text()"/>
        (<xsl:value-of select="version/text()"/>)
      </h3>
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
    <a href="mailto:{text()}"><tt><xsl:value-of select="text()"/></tt></a>
  </xsl:template>

</xsl:stylesheet>
