command! ReloadSnippets :source ~/.vim/ftplugin/xml_snippets.vim

iab nsNC http://home.netscape.com/NC-rdf#
iab nsWEB http://home.netscape.com/WEB-rdf#
iab nsRDF http://www.w3.org/1999/02/22-rdf-syntax-ns#
iab nsFLOCK http://flock.com/rdf#
iab nsXUL http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul
iab nsXBL http://www.mozilla.org/xbl

Iabbr cset <commandset id="flock_@id@CommandSet" />
Iabbr cmd <command id="cmd_@name@" oncommand="goDoCommand('cmd_@name@')" />


Iabbr constructor <constructor>
Iabbr destructor <destructor>
Iabbr field <field name="@name@">@null@</field>
Iabbr fieldb <field name="@name@">


Iabbr prop <property name="@name@"><!--{{{-->
Iabbr propr <property name="@name@" readonly="true"><!--{{{-->
Iabbr propq <!-- propq: @name@ --><!--{{{-->
Iabbr propp <!-- propp: @name@ --><!--{{{-->
Iabbr fprop <!-- fprop: @name@ --><!--{{{-->
Iabbr fmprop <!-- fmprop: @name@ --><!--{{{-->
Iabbr propb <!-- propb: @name@ --><!--{{{-->


Iabbr method <method name="@name@"><!--{{{-->
Iabbr methode <method name="@name@"><!--{{{-->

Iabbr param <parameter name="@name@" />
Iabbr handler <handler event="@event@"><!--{{{-->
Iabbr handlerc <handler event="@event@" phase="capturing"><!--{{{-->
Iabbr cdata <![CDATA[