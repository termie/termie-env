command! ReloadSnippets :source ~/.vim/ftplugin/xml_snippets.vim

iab nsNC http://home.netscape.com/NC-rdf#
iab nsWEB http://home.netscape.com/WEB-rdf#
iab nsRDF http://www.w3.org/1999/02/22-rdf-syntax-ns#
iab nsFLOCK http://flock.com/rdf#
iab nsXUL http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul
iab nsXBL http://www.mozilla.org/xbl

Iabbr cset <commandset id="flock_@id@CommandSet" />
Iabbr cmd <command id="cmd_@name@" oncommand="goDoCommand('cmd_@name@')" />


Iabbr constructor <constructor><![CDATA[@@]]></constructor>
Iabbr destructor <destructor><![CDATA[@@]]></destructor>
Iabbr field <field name="@name@">@null@</field>
Iabbr fieldb <field name="@name@"><![CDATA[@@]]></field>


Iabbr prop <property name="@name@"><!--{{{--><getter><![CDATA[@getter@]]></getter><setter><![CDATA[@setter@]]></setter></property><!--}}}-->
Iabbr propr <property name="@name@" readonly="true"><!--{{{--><getter><![CDATA[@@]]></getter></property><!--}}}-->
Iabbr propq <!-- propq: @name@ --><!--{{{--><property name="@name@"onget="return this.getAttribute('@name@')"onset="return this.setAttribute('@name@', val);"/><!--}}}-->
Iabbr propp <!-- propp: @name@ --><!--{{{--><property name="@name@"onget="return this.@proxy@.@name@;"onset="return this.@proxy@.@name@ = val;"/><!--}}}-->
Iabbr fprop <!-- fprop: @name@ --><!--{{{--><field name="_@name@">@null@</field><property name="@name"onset="this._@name@ = val;"><getter><![CDATA[if (this._@name@ != null) return this._@name@;var @name@ = @@;this._@name@ = @name@;return this._@name@;]]></getter></property><!--}}}-->
Iabbr fmprop <!-- fmprop: @name@ --><!--{{{--><field name="_@name@">null</field><property name="@name@"onset="this._@name@ = val;"><getter><![CDATA[if (this._@name@ != null) return this._@name@;var @name@ = document.getAnonymousElementByAttribute(this, 'anonid', '@name@');;this._@name@ = @name@;return this._@name@;]]></getter></property><!--}}}-->
Iabbr propb <!-- propb: @name@ --><!--{{{--><property name="@name@"onget="return (this.getAttribute('@name@') != 'false');"><setter><![CDATA[if (val && val != "false" && !this.@name@) {this.setAttribute('@name@', 'true');}else if (this.@name@) {this.setAttribute('@name@', 'false');}]]></setter></property><!--}}}-->


Iabbr method <method name="@name@"><!--{{{--><body><![CDATA[@@]]></body></method><!--}}}-->
Iabbr methode <method name="@name@"><!--{{{--><parameter name="aEvt" /><body><![CDATA[@@]]></body></method><!--}}}-->

Iabbr param <parameter name="@name@" />
Iabbr handler <handler event="@event@"><!--{{{--><![CDATA[@@]]></handler><!--}}}-->
Iabbr handlerc <handler event="@event@" phase="capturing"><!--{{{--><![CDATA[@@]]></handler><!--}}}-->
Iabbr cdata <![CDATA[@@]]>
