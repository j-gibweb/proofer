<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://service.nordstrom.net/schema/CustomerOrder/v1" xmlns:ns1="http://service.nordstrom.net/schema/TransactionCommon/v1">
<xsl:output method="html" indent="yes" />
<xsl:template match="*[local-name()='RetailTransactionLines']">

<!-- Start Order Number Headline -->
<table cellpadding="0" cellspacing="0" width="598" class="width292">
<tr>
      <td align="left" width="598" height="25" class="width292" background="images/gray_tile1x25.gif" bgcolor="#d1cdca">
    	<div style="font-family:Georgia, 'Times New Roman', Times, serif; font-size:16px; color:#000000; line-height:18px; padding-left:9px;" class="ml9">Your Shipment Details</div>
      </td>
</tr>
<tr><td height="1" bgcolor="#e4e4e3" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
<tr><td height="1" bgcolor="#e8e8e9" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
<tr><td height="1" bgcolor="#eeedee" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
<tr><td height="1" bgcolor="#f3f2f3" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
<tr><td height="1" bgcolor="#f7f7f7" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
<tr><td height="1" bgcolor="#fcfcfc" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
</table>
<!-- End Order Number Headline -->

<table cellpadding="0" cellspacing="0"><tr><td height="8" style="font-size:8px; line-height:8px;"></td></tr></table>

<!-- Start Purchase Details -->
<table cellpadding="0" cellspacing="0" width="598" class="width292">
<tr>
    <td width="10" class="width8"></td>
    <td align="left" valign="top" width="588" class="width284">
        <table cellpadding="0" cellspacing="0" width="588" class="width284">
        <tr>
          <td width="294" align="left" valign="top" class="block width284">

<!-- Conditional to hide Purchased On info if it's null -->
     
$cond(empty(lookup(TransactionDate)),nothing(),document(lookup(currentFolder),PurchasedOn))$    

      			<table cellspacing="0" cellpadding="0"><tr><td height="12" style="font-size:12px; line-height:12px;">&#160;</td></tr></table>
          </td>
          <td width="294" align="left" valign="top" class="block width284">
 
$cond(empty(lookup(SoldToName)),nothing(),document(lookup(currentFolder),PurchasedBy))$  

  
      			<table cellspacing="0" cellpadding="0"><tr><td height="12" style="font-size:12px; line-height:12px;">&#160;</td></tr></table>
          </td>
      	</tr>
        </table>
    </td>
</tr>
</table>
<!-- End Purchase Details -->

<xsl:for-each select="*[local-name()='RetailTransactionLine']">

<table cellpadding="0" cellspacing="0" width="598" class="width292">
<tr><td height="6" style="font-size:6px; line-height:6px;">&#160;</td></tr>
<tr><td height="1" bgcolor="#edeaea" style="line-height:1px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;" /></td></tr>
<tr><td height="19"></td></tr>
</table>

<!-- Start Product Grid -->
<table cellpadding="0" cellspacing="0" width="598" class="width292">
<tr>
  <td width="9" class="width10"></td>
  <td width="103" height="135" align="left" valign="top" class="hide">
       <!-- Start Condition-If Product Link Exists/NotExists -->
        <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']) &gt; 0">
              
              <!-- Start When ImageURL Exists -->
              <xsl:choose>
                  <xsl:when test="string-length(*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']) &gt; 0">
                      <!-- Start Clickthrough Function Calling Link 'productimg#' # Based On Item Position.  Passing XML Field 'ProductPageWebLinkTextPt' As RI Variable 'prodURL' Used In Link Table -->
                      
                      <a target="_blank"><xsl:attribute name="href">&#36;clickthrough(productimg<xsl:value-of select="position()" />,concat(prodURL=,<xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']" />),cmite=productimg<xsl:value-of select="position()" />)&#36;</xsl:attribute>
                      <img width="88" height="135" style="display:block; border:0;" class="hide" ><xsl:attribute name="src"><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']" /></xsl:attribute></img></a>
      
                  </xsl:when>
                  <xsl:otherwise>
                      <!-- Start Clickthrough Function Calling Link 'productimg#' # Based On Item Position.  Passing XML Field 'ProductPageWebLinkTextPt' As RI Variable 'prodURL' Used In Link Table -->
                      <a target="_blank"><xsl:attribute name="href">&#36;clickthrough(productimg<xsl:value-of select="position()" />,concat(prodURL=,<xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']" />),cmite=productimg<xsl:value-of select="position()" />)&#36;</xsl:attribute>
                      <img src="images/default_img.jpg" width="88" height="135" alt="NO IMAGE AVAILABLE" style="display:block; border:0;" /></a>
                  </xsl:otherwise>
              </xsl:choose>
              <!-- End When ImageURL Exists -->
              
      <!-- End Clickthrough Function -->
          </xsl:if>
          <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']) = 0">
              
              <!-- Start When ImageURL Exists -->
              <xsl:choose>
                  <xsl:when test="string-length(*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']) &gt; 0">
              
                      <img width="88" height="135" style="display:block; border:0;" class="hide" ><xsl:attribute name="src"><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']" /></xsl:attribute></img>
          
                  </xsl:when>
                  <xsl:otherwise>
                      <img src="images/default_img.jpg" width="88" height="135" alt="NO IMAGE AVAILABLE" style="display:block; border:0;" />
                  </xsl:otherwise>
              </xsl:choose>
              <!-- End When ImageURL Exists -->
                  
          </xsl:if>
          <!-- End Condition-If Product Link Exists -->     

  </td>
  <td width="486" align="left" valign="middle" class="block width282">
       <div style="font-family:Verdana, Geneva, sans-serif; font-size:12px;">
          <div style="line-height:16px; color:#646464;">Description:</div>

<!-- Start Condition for displaying description of Merch items -->
<xsl:if test="normalize-space(*[local-name()='TransactionLineType']/*[local-name()='MerchandiseLine']) != ''">

            <!-- Start Condition-If Product Link Exists -->		  
            
      <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']) &gt; 0">
            <!-- Start Clickthrough Function Calling Link 'productimg#' # Based On Item Position.  Passing XML Field 'ProductPageWebLinkTextPt' As RI Variable 'prodURL' Used In Link Table -->		  
              <div style="line-height:16px; color:#646464;"><a style="color:#990000; text-decoration:underline;"><xsl:attribute name="href">&#36;clickthrough(proddescr<xsl:value-of select="position()" />,concat(prodURL=<xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']" />),cmite=productimg<xsl:value-of select="position()" />)&#36;</xsl:attribute><span><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='LegacyLineProductDetail']/*[local-name()='LegacyWebProductStyleDescription']" /></span></a></div>
  		   <!-- End Clickthrough Function -->		
           </xsl:if>
   
   <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']) = 0">
             <div style="line-height:16px; color:#000001;"><span><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='LegacyLineProductDetail']/*[local-name()='LegacyWebProductStyleDescription']" /></span></div>
  		   <!-- End Clickthrough Function -->		
           </xsl:if>
                  
            <!-- End Condition-If Product Link Exists -->
             <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductItemPrimaryUpcPt']) &gt; 0">	  
              <div style="line-height:16px; color:#000001;"><span class="order_num"><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductStyleDescriptionPt']" />&#xA0;(<xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductItemPrimaryUpcPt']" />)</span></div>
            </xsl:if>	    
  
</xsl:if>
<!-- End Condition for displaying description of Merch items -->      
        
<!-- Start Condition for displaying description of NonMerch items -->
 <xsl:if test="normalize-space(*[local-name()='TransactionLineType']/*[local-name()='NonMerchandiseFeeCodeLine']/*[local-name()='FeeType']/*[local-name()='Code']) != ''">
 <div style="line-height:16px; color:#000001;"><span><xsl:value-of select="*[local-name()='TransactionLineType']/*[local-name()='NonMerchandiseFeeCodeLine']/*[local-name()='FeeType']/*[local-name()='Description']" />&#xA0;(<xsl:value-of select="*[local-name()='TransactionLineType']/*[local-name()='NonMerchandiseFeeCodeLine']/*[local-name()='FeeType']/*[local-name()='Code']" />)</span></div>

 </xsl:if>        
<!-- End Condition for displaying description of NonMerch items -->
        
	  </div>
      <table cellpadding="0" cellspacing="0"><tr><td height="13" style="font-size:13px; line-height:13px;">&#160;</td></tr></table>
      
      <table cellpadding="0" cellspacing="0" width="1" class="floatleft width74">
      <tr>
      		<td align="left" valign="top" width="1" height="0" class="width66 height101 floatleft">
          		<!-- Start Condition-If Product Link Exist (Responsive) -->
                <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']) &gt; 0">
                         
                      <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']) &gt; 0">
                         <!-- Start Clickthrough Function Calling Link 'productimg#' # Based On Item Position.  Passing XML Field 'ProductPageWebLinkTextPt' As RI Variable 'prodURL' Used In Link Table -->
                         <div class="show" style="display:none; float:left; overflow:hidden; width:0; max-height:0; line-height:0;">
                              <a target="_blank"><xsl:attribute name="href">&#36;clickthrough(productimg<xsl:value-of select="position()" />,concat(prodURL=,<xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']" />),cmite=productimg<xsl:value-of select="position()" />)&#36;</xsl:attribute>
                              <img width="1" height="0" style="display:block; border:0;" class="width66 height101" ><xsl:attribute name="src"><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']" /></xsl:attribute></img></a>
                          </div>
                          <!-- End Clickthrough Function -->
                      </xsl:if>     
                       
                       <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']) = 0">
                          <!-- Start Clickthrough Function Calling Link 'productimg#' # Based On Item Position.  Passing XML Field 'ProductPageWebLinkTextPt' As RI Variable 'prodURL' Used In Link Table -->
                         <div class="show" style="display:none; float:left; overflow:hidden; width:0; max-height:0; line-height:0;">
                             <a target="_blank"><xsl:attribute name="href">&#36;clickthrough(productimg<xsl:value-of select="position()" />,concat(prodURL=,<xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']" />),cmite=productimg<xsl:value-of select="position()" />)&#36;</xsl:attribute>
                              <img src="images/defaultsm_img.jpg" width="1" height="0" alt="NO IMAGE AVAILABLE" style="display:block; border:0;" class="width66 height101" />
                              </a>
                          </div>
                          <!-- End Clickthrough Function -->
                     </xsl:if>
              </xsl:if>
              <!-- End Condition-If Product Link Exists (Responsive) -->
              
              <!-- Start Condition-If Product Link Does Not Exist (Responsive) -->
              <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductPageWebLinkTextPt']) = 0">
                     <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']) &gt; 0">
                        <div class="show" style="display:none; float:left; overflow:hidden; width:0; max-height:0; line-height:0;">
                           <img width="1" height="0" style="display:block; border:0;" class="width66 height101" ><xsl:attribute name="src"><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']" /></xsl:attribute></img>
                        </div>
                     </xsl:if>
                     
                     <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='LineProductDetailImages']/*[local-name()='LineProductDetailImage']/*[local-name()='FileLinkText']) = 0">
                        <div class="show" style="display:none; float:left; overflow:hidden; width:0; max-height:0; line-height:0;"><img src="images/defaultsm_img.jpg" width="1" height="0" alt="NO IMAGE AVAILABLE" style="display:block; border:0;" class="width66 height101" /></div>
                     </xsl:if>
               </xsl:if>
              <!-- End Condition-If Product Link Does Not Exists (Responsive) -->
          
          </td>
      </tr>
      </table>
      
      <div class="floatleft width206">
        <table cellpadding="0" cellspacing="0" class="width206">
        <tr>
            <td width="110" align="left" valign="top" class="block width206">
                  <div style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:#646464; line-height:16px;">
                      Qty:<br class="hide" />
                   <span style="color:#010101;">1</span>
                  </div>
                  <table cellpadding="0" cellspacing="0"><tr><td height="7" style="font-size:7px; line-height:7px;">&#160;</td></tr></table>
            </td>
            <!-- Start Hide Color Label IF No Value -->
            <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductStyleCustomerChoiceDisplayColorDescriptionPt']) &gt; 0">
            <td width="188" align="left" valign="top" class="block width206">
            	
                    <div style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:#646464; line-height:16px;">
                        Color:<br class="hide" />
                         <span style="color:#010101;">



  <!-- Start Uppercase First Letter Every Word -->
                                             <xsl:call-template name="upperCase">
                                                <xsl:with-param name="text">
                                                <xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductStyleCustomerChoiceDisplayColorDescriptionPt']" />  
                                                </xsl:with-param>
                                             </xsl:call-template>	
                                             <!-- End Uppercase First Letter Every Word -->

</span>
                    </div>
                
                <table cellpadding="0" cellspacing="0"><tr><td height="7" style="font-size:7px; line-height:7px;">&#160;</td></tr></table>
            </td>
            </xsl:if>
            <!-- End Hide Color Label IF No Value -->
            
            <!-- Start Hide Size Label IF No Value -->
            <xsl:if test="string-length(*[local-name()='LineProductDetail']/*[local-name()='ProductSkuItemNordstromSizePt']) &gt; 0">
            <td width="188" align="left" valign="top" class="block width206">
              <div style="font-family:Verdana, Geneva, sans-serif; font-size:12px; color:#646464; line-height:16px;">
                  Size:<br class="hide" />
                  <span style="color:#010101;"><xsl:value-of select="*[local-name()='LineProductDetail']/*[local-name()='ProductSkuItemNordstromSizePt']" /></span>
              </div>
              <table cellpadding="0" cellspacing="0"><tr><td height="7" style="font-size:7px; line-height:7px;">&#160;</td></tr></table>
            </td>
            </xsl:if>
            <!-- End Hide Size Label IF No Value -->
        </tr>
        </table>
      </div>
  </td>
</tr>
</table>

<table cellpadding="0" cellspacing="0"><tr><td height="13" style="font-size:13px; line-height:13px;">&#160;</td></tr></table>
<!-- End Product Grid -->


<!-- Start Only Show Gray Divider Between Distinct Products and Not the Last Product -->

<!-- End Only Show Gray Divider Between Distinct Products and Not the Last Product -->



</xsl:for-each>


</xsl:template>

 <!-- Start Uppercase Template -->
    <xsl:template name="upperCase">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text,' ')">
        <xsl:call-template name="upperCaseWord">
          <xsl:with-param name="text" select="substring-before($text,' ')"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:call-template name="upperCase">
          <xsl:with-param name="text"	select="substring-after($text,' ')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="upperCaseWord">
          <xsl:with-param name="text" select="$text"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <xsl:template name="upperCaseWord">
    <xsl:param name="text"/>
       <!-- Start If Within a Paranthesies, Capitalize First Letter -->
       <xsl:if test="contains($text,'&#40;')">
          	<xsl:value-of select="substring($text,1,1)" /><xsl:value-of select="translate(substring($text,2,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" />
            <xsl:value-of select="translate(substring($text,3,string-length($text)-2),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')" />
            <!-- Start If Within a Paranthesies, Capitalize First Letter -->
              
      </xsl:if>
      <!-- End If Within a Paranthesies, Capitalize First Letter -->
      <xsl:if test="not(contains($text,'&#40;')) and not(contains($text,'/'))">
          <xsl:value-of select="translate(substring($text,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')" /><xsl:value-of select="translate(substring($text,2,string-length($text)-1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')" />
      </xsl:if>
	  <!-- If Color contains '/' -->
	  <xsl:if test="not(contains($text,'&#40;')) and contains($text,'/')">
          $replaceall(capitalizewords(<xsl:value-of select="translate($text,'/','-')" />),-,/)$
      </xsl:if>
	</xsl:template>
    <!-- End Uppercase Template -->
	

</xsl:stylesheet>


