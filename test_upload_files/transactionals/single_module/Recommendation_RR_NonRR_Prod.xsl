<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soap="http://soap.ws.nordstrom.services.responsys.com" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="http://service.nordstrom.net/schema/CustomerOrder/v1" xmlns:ns1="http://service.nordstrom.net/schema/TransactionCommon/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema">

<xsl:output method="html" indent="yes" />
<xsl:template match="*[local-name()='ProductRecommendationDetailsOut']">
        
<!-- Choose which provider engine to use 'RichRelevance' or is not 'RichRelevance' -->				
<xsl:choose>
	<!-- When 'Provider' = RichRelevance, use RichRelevance template -->
	<xsl:when test="*[local-name()='ProductRecommendationDetail']/*[local-name()='Provider'] = 'RichRelevance'">
		<!-- Create variable for 'Provider' field to use for external tracking -->
			<xsl:variable name="provider">
				<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='Provider']"/>
			</xsl:variable>
		<!-- /Create variable for 'Provider' field to use for external tracking -->
		<!-- Explore -->
		<table cellpadding="0" cellspacing="0" width="598" class="hide">
			<tr>
				<td width="598" class="tdwrap" align="left" valign="top">
					<div>
						<img width="598" height="256" border="0" usemap="#Map" style="display:block;">
							<xsl:attribute name="src">
								<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='ProductRecommendationInfo'][position() = 5]/*[local-name()='ImageURLOut']" />
							</xsl:attribute>
						</img>
					</div>
				</td>
			</tr>
		</table>      
		<!-- /Explore -->
		<!-- Replace Nordstrom encoding of ampersand with correct -->
				&#36;setvars(recURL1,<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='ProductRecommendationInfo'][position()=1]/*[local-name()='ProductPageURLOut']" />,recURL2,<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='ProductRecommendationInfo'][position()=2]/*[local-name()='ProductPageURLOut']" />,recURL3,<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='ProductRecommendationInfo'][position()=3]/*[local-name()='ProductPageURLOut']" />,recURL4,<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='ProductRecommendationInfo'][position()=4]/*[local-name()='ProductPageURLOut']" />)&#36;

				&#36;setglobalvars(recOutURL1,replaceall(lookup(recURL1),&#38;,lookup(amp)),recOutURL2,replaceall(lookup(recURL2),&#38;,lookup(amp)),recOutURL3,replaceall(lookup(recURL3),&#38;,lookup(amp)),recOutURL4,replaceall(lookup(recURL4),&#38;,lookup(amp)))&#36;
		<!-- /Replace Nordstrom encoding of ampersand with correct -->

		<map name="Map">
			<area shape="rect" coords="494,0,593,25" href="&#36;clickthrough(seemore,cmite=seemore)&#36;"/>
			$setvars(prodURL,lookup(recOutURL1))$
			<area shape="rect" coords="0,41,139,251" >
				<xsl:attribute name="href">&#36;clickthrough(recimg1,cmite=recimg1_<xsl:value-of select="$provider"/>,prodURL)&#36;</xsl:attribute>
			</area>$setvars(prodURL,lookup(recOutURL2))$
			<area shape="rect" coords="154,41,293,251" >
				<xsl:attribute name="href">&#36;clickthrough(recimg2,cmite=recimg2_<xsl:value-of select="$provider"/>,prodURL)&#36;</xsl:attribute>
			</area>$setvars(prodURL,lookup(recOutURL3))$
			<area shape="rect" coords="307,41,446,251" >
				<xsl:attribute name="href">&#36;clickthrough(recimg3,cmite=recimg3_<xsl:value-of select="$provider"/>,prodURL)&#36;</xsl:attribute>
			</area>$setvars(prodURL,lookup(recOutURL4))$
			<area shape="rect" coords="454,41,598,251" >
				<xsl:attribute name="href">&#36;clickthrough(recimg4,cmite=recimg4_<xsl:value-of select="$provider"/>,prodURL)&#36;</xsl:attribute>
			</area>
		</map>
        
        					
							<table cellpadding="0" cellspacing="0" width="598" class="hide">
              				<tr>
              				<xsl:for-each select="*[local-name()='ProductRecommendationDetail'] /*[local-name()='ProductRecommendationInfo']">
							<xsl:if test="not(position() > 4)">
                                <td width="148" align="left" valign="top" class="tdwrap">
                                    
                                    <div style="font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#646464; line-height:15px;">	
                      					<a style="font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#646464; text-decoration:none;" target="_blank">
										<xsl:attribute name="href">$clickthrough(recimg<xsl:value-of select="position()" />,cmite=recimg<xsl:value-of select="position()" />_<xsl:value-of select="$provider"/>_<xsl:value-of select="*[local-name()='Strategy']"/>,prodURL=<xsl:value-of select="*[local-name()='ProductPageURLOut']"/>)$</xsl:attribute>
                                        <xsl:value-of select="*[local-name()='Name']"/>  
                                       	</a>               
									</div>
                                    
                                    <div style="font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#010101; line-height:20px;">	
                      					<xsl:value-of select="*[local-name()='FormattedRegularPrice']"/>                   
									</div>
	                  			</td>
                      		</xsl:if>
                      		</xsl:for-each>
	                		</tr>
	            			</table>
                            
	</xsl:when>
	<!-- /When 'Provider' = RichRelevance, use RichRelevance template -->
	<!-- When 'Provider' != RichRelevance, use Non RichRelevance template -->
	<xsl:when test="*[local-name()='ProductRecommendationDetail']/*[local-name()='Provider'] != 'RichRelevance'">
		<!-- Create flag for number of recommended items -->
		<xsl:variable name="count">
			<xsl:for-each select="*[local-name()='ProductRecommendationDetail']/*[local-name()='ProductRecommendationInfo']">1</xsl:for-each>
		</xsl:variable>
		<!-- /Create flag for number of recommended items -->
		<!-- Display if more than 0 items exist -->
		<xsl:choose>
			<xsl:when test="normalize-space($count) != ''">
				<!-- Create variable for 'Provider' field to use for external tracking -->
				<xsl:variable name="provider">
					<xsl:value-of select="*[local-name()='ProductRecommendationDetail']/*[local-name()='Provider']"/>
				</xsl:variable>
				<!-- /Create variable for 'Provider' field to use for external tracking -->
				<!-- Instead Headline -->
				<table cellpadding="0" cellspacing="0" width="598" class="width292">
					<tr>
						<td width="9"  />
						<td align="left" width="460" height="25" class="width206" >
							<div style="font-family:Arial, Helvetica, sans-serif; font-size:15px; color:#646464; line-height:17px;"><span class="fontsmallb">$cond(empty(lookup(recHeading)),More to Explore:,lookup(recHeading))$</span></div>
						</td>
						<td align="right" width="110" height="25" >
							
						</td>
						<td align="right" width="10" height="25" >
							
						</td>
						<td width="9" class="hide" />
					</tr>
					<tr><td colspan="5" height="5" style="line-height:5px;"><img src="images/spcr.gif" width="1" height="1" border="0" style="display:block;"/></td></tr>
					<tr><td colspan="5" height="1" bgcolor="#edeaea"/></tr>
					<tr><td colspan="5" height="1" /></tr>
				</table>
				<!-- Instead Looking Headline -->
				<table cellpadding="0" cellspacing="0"><tr><td height="5"/></tr></table>
	
				<!-- START PRODUCT GRID XSL -->
				<table cellpadding="0" cellspacing="0" width="598" class="width292">
					<!-- START ROW 1 -->
					<tr>
						<td align="center">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<!-- START PRODUCT GRID INNER ** MAX 4 PRODUCTS PER ROW ** -->		  
									<xsl:for-each select="*[local-name()='ProductRecommendationDetail'] /*[local-name()='ProductRecommendationInfo']">
										<xsl:if test="not(position() > 4)">
											<td width="198" align="center" valign="bottom" class="tdwrap">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td align="left" width="149">
															<div style="font-family:Verdana, Geneva, sans-serif;">
																<a target="_blank">
																	<xsl:attribute name="href">$clickthrough(recimg<xsl:value-of select="position()" />,cmite=recimg<xsl:value-of select="position()" />_<xsl:value-of select="$provider"/>_<xsl:value-of select="*[local-name()='Strategy']"/>,prodURL=<xsl:value-of select="*[local-name()='ProductPageURLOut']"/>)$</xsl:attribute>
																	<xsl:element name="img">                   
																		<xsl:attribute name="src">
																			<xsl:value-of select="*[local-name()='ImageURLOut']" />
																		</xsl:attribute>
																		<xsl:attribute name="width">139</xsl:attribute>                    
																		<xsl:attribute name="style">display:block;</xsl:attribute>
																		<xsl:attribute name="border">0</xsl:attribute>
																		<!-- If there are 3 items only display first 2 for responsive -->
																		<xsl:if test="normalize-space($count) = 111 and position() = 3">
																		<xsl:attribute name="class">hide</xsl:attribute>
																		</xsl:if>
																		<!-- /If there are 3 items only display first 2 for responsive -->
																	</xsl:element>
                                                                    
																</a>  
                                                                <table cellpadding="0" cellspacing="0"><tr><td height="7"/></tr></table>
															</div>
                                                            
														</td>                        
														<xsl:if test="position() mod 2 != 0">
															<td width="13" class="tdwrap"/>
														</xsl:if>        
														<xsl:if test="position() = 2">
															<td width="13" class="hide"/>
														</xsl:if>
													</tr>
												</table>
                                                
											</td>
										</xsl:if>
									</xsl:for-each>
									<!-- END PRODUCT GRID INNER -->
								</tr>
							</table>
							
							<table cellpadding="0" cellspacing="0" width="598" class="width292">
              				<tr>
              				<xsl:for-each select="*[local-name()='ProductRecommendationDetail'] /*[local-name()='ProductRecommendationInfo']">
							<xsl:if test="not(position() > 4)">
                                <td width="148" align="left" valign="top" class="tdwrap">
                                    
                                    <div style="font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#646464; line-height:15px;">	
                      					<a style="font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#646464; text-decoration:none;" target="_blank">
										<xsl:attribute name="href">$clickthrough(recimg<xsl:value-of select="position()" />,cmite=recimg<xsl:value-of select="position()" />_<xsl:value-of select="$provider"/>_<xsl:value-of select="*[local-name()='Strategy']"/>,prodURL=<xsl:value-of select="*[local-name()='ProductPageURLOut']"/>)$</xsl:attribute>
                                        <xsl:value-of select="*[local-name()='Name']"/>  
                                       	</a>               
									</div>
                                    
                                    <div style="font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#010101; line-height:20px;">	
                      					<xsl:value-of select="*[local-name()='FormattedRegularPrice']"/>                   
									</div>
	                  			</td>
                      		</xsl:if>
                      		</xsl:for-each>
	                		</tr>
	            			</table>

						</td>
					</tr>
					<!-- END ROW 1 -->
					<tr><td colspan="2" height="10"/></tr>
					<!-- SPACER BETWEEN ROW -->
				</table>
				<!-- END PRODUCT GRID XSL -->
			</xsl:when>
			<xsl:otherwise>$nothing()$</xsl:otherwise>
		</xsl:choose>
		<!-- /Display if more than 0 items exist -->
	</xsl:when>
	<xsl:otherwise>$nothing()$</xsl:otherwise>
</xsl:choose>
<!-- Choose which provider engine to use 'RichRelevance' or is not 'RichRelevance' -->	
                    	
</xsl:template>
</xsl:stylesheet>
