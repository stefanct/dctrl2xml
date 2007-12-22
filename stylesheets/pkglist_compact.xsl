<?xml version="1.0" encoding="UTF-8"?>
<!--
  Here is an example how dctrl2xml and this stylesheet can be used to
  create a packages overview page from a repository's Packages file:

  dctrl2xml -f /var/lib/apt/lists/ftp.debian.org_debian_dists_sid_main_binary-i386_Packages > /tmp/packages.xml
  xsltproc -o /tmp/packages_compact.html pkglist_compact.xsl /tmp/packages.xml
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
      <table>
        <thead>
          <tr>
            <td>Name</td>
            <td>Architecture</td>
            <td>Maintainer</td>
          </tr>
        </thead>
        <xsl:apply-templates select="package"/>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="package">
    <tr>
      <td>
        <xsl:value-of select="name/text()"/>
        (<a href="{$base_address}{filename/text()}"
          ><xsl:value-of select="version/text()"/></a>)
      </td>
      <td><xsl:value-of select="architecture/text()"/></td>
      <td><xsl:apply-templates select="maintainer"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="maintainer">
    <a href="mailto:{contact/email/text()}"
      ><xsl:value-of select="contact/name/text()"/></a>
  </xsl:template>

</xsl:stylesheet>
