var hljs=new function(){function e(e){return e.replace(/&/gm,"&amp;").replace(/</gm,"&lt;").replace(/>/gm,"&gt;")}function t(e){return e.nodeName.toLowerCase()}function r(e,t){var r=e&&e.exec(t);return r&&0==r.index}function n(e){return Array.prototype.map.call(e.childNodes,function(e){return 3==e.nodeType?v.useBR?e.nodeValue.replace(/\n/g,""):e.nodeValue:"br"==t(e)?"\n":n(e)}).join("")}function a(e){var t=(e.className+" "+(e.parentNode?e.parentNode.className:"")).split(/\s+/);return t=t.map(function(e){return e.replace(/^language-/,"")}),t.filter(function(e){return N(e)||"no-highlight"==e})[0]}function i(e,t){var r={};for(var n in e)r[n]=e[n];if(t)for(var n in t)r[n]=t[n];return r}function c(e){var r=[];return function n(e,a){for(var i=e.firstChild;i;i=i.nextSibling)3==i.nodeType?a+=i.nodeValue.length:"br"==t(i)?a+=1:1==i.nodeType&&(r.push({event:"start",offset:a,node:i}),a=n(i,a),r.push({event:"stop",offset:a,node:i}));return a}(e,0),r}function s(r,n,a){function i(){return r.length&&n.length?r[0].offset!=n[0].offset?r[0].offset<n[0].offset?r:n:"start"==n[0].event?r:n:r.length?r:n}function c(r){function n(t){return" "+t.nodeName+'="'+e(t.value)+'"'}l+="<"+t(r)+Array.prototype.map.call(r.attributes,n).join("")+">"}function s(e){l+="</"+t(e)+">"}function o(e){("start"==e.event?c:s)(e.node)}for(var u=0,l="",f=[];r.length||n.length;){var b=i();if(l+=e(a.substr(u,b[0].offset-u)),u=b[0].offset,b==r){f.reverse().forEach(s);do o(b.splice(0,1)[0]),b=i();while(b==r&&b.length&&b[0].offset==u);f.reverse().forEach(c)}else"start"==b[0].event?f.push(b[0].node):f.pop(),o(b.splice(0,1)[0])}return l+e(a.substr(u))}function o(e){function t(e){return e&&e.source||e}function r(r,n){return RegExp(t(r),"m"+(e.cI?"i":"")+(n?"g":""))}function n(a,c){function s(t,r){e.cI&&(r=r.toLowerCase()),r.split(" ").forEach(function(e){var r=e.split("|");o[r[0]]=[t,r[1]?Number(r[1]):1]})}if(!a.compiled){if(a.compiled=!0,a.k=a.k||a.bK,a.k){var o={};"string"==typeof a.k?s("keyword",a.k):Object.keys(a.k).forEach(function(e){s(e,a.k[e])}),a.k=o}a.lR=r(a.l||/\b[A-Za-z0-9_]+\b/,!0),c&&(a.bK&&(a.b=a.bK.split(" ").join("|")),a.b||(a.b=/\B|\b/),a.bR=r(a.b),a.e||a.eW||(a.e=/\B|\b/),a.e&&(a.eR=r(a.e)),a.tE=t(a.e)||"",a.eW&&c.tE&&(a.tE+=(a.e?"|":"")+c.tE)),a.i&&(a.iR=r(a.i)),void 0===a.r&&(a.r=1),a.c||(a.c=[]);var u=[];a.c.forEach(function(e){e.v?e.v.forEach(function(t){u.push(i(e,t))}):u.push("self"==e?a:e)}),a.c=u,a.c.forEach(function(e){n(e,a)}),a.starts&&n(a.starts,c);var l=a.c.map(function(e){return e.bK?"\\.?\\b("+e.b+")\\b\\.?":e.b}).concat([a.tE]).concat([a.i]).map(t).filter(Boolean);a.t=l.length?r(l.join("|"),!0):{exec:function(){return null}},a.continuation={}}}n(e)}function u(t,n,a,i){function c(e,t){for(var n=0;n<t.c.length;n++)if(r(t.c[n].bR,e))return t.c[n]}function s(e,t){return r(e.eR,t)?e:e.eW?s(e.parent,t):void 0}function f(e,t){return!a&&r(t.iR,e)}function b(e,t){var r=y.cI?t[0].toLowerCase():t[0];return e.k.hasOwnProperty(r)&&e.k[r]}function h(e,t,r,n){var a=n?"":v.classPrefix,i='<span class="'+a,c=r?"":"</span>";return i+=e+'">',i+t+c}function g(){var t=e(C);if(!L.k)return t;var r="",n=0;L.lR.lastIndex=0;for(var a=L.lR.exec(t);a;){r+=t.substr(n,a.index-n);var i=b(L,a);i?(B+=i[1],r+=h(i[0],a[0])):r+=a[0],n=L.lR.lastIndex,a=L.lR.exec(t)}return r+t.substr(n)}function p(){if(L.sL&&!E[L.sL])return e(C);var t=L.sL?u(L.sL,C,!0,L.continuation.top):l(C);return L.r>0&&(B+=t.r),"continuous"==L.subLanguageMode&&(L.continuation.top=t.top),h(t.language,t.value,!1,!0)}function d(){return void 0!==L.sL?p():g()}function m(t,r){var n=t.cN?h(t.cN,"",!0):"";t.rB?(R+=n,C=""):t.eB?(R+=e(r)+n,C=""):(R+=n,C=r),L=Object.create(t,{parent:{value:L}})}function M(t,r){if(C+=t,void 0===r)return R+=d(),0;var n=c(r,L);if(n)return R+=d(),m(n,r),n.rB?0:r.length;var a=s(L,r);if(a){var i=L;i.rE||i.eE||(C+=r),R+=d();do L.cN&&(R+="</span>"),B+=L.r,L=L.parent;while(L!=a.parent);return i.eE&&(R+=e(r)),C="",a.starts&&m(a.starts,""),i.rE?0:r.length}if(f(r,L))throw new Error('Illegal lexeme "'+r+'" for mode "'+(L.cN||"<unnamed>")+'"');return C+=r,r.length||1}var y=N(t);if(!y)throw new Error('Unknown language: "'+t+'"');o(y);for(var L=i||y,R="",A=L;A!=y;A=A.parent)A.cN&&(R=h(A.cN,R,!0));var C="",B=0;try{for(var w,_,k=0;;){if(L.t.lastIndex=k,w=L.t.exec(n),!w)break;_=M(n.substr(k,w.index-k),w[0]),k=w.index+_}M(n.substr(k));for(var A=L;A.parent;A=A.parent)A.cN&&(R+="</span>");return{r:B,value:R,language:t,top:L}}catch(x){if(-1!=x.message.indexOf("Illegal"))return{r:0,value:e(n)};throw x}}function l(t,r){r=r||v.languages||Object.keys(E);var n={r:0,value:e(t)},a=n;return r.forEach(function(e){if(N(e)){var r=u(e,t,!1);r.language=e,r.r>a.r&&(a=r),r.r>n.r&&(a=n,n=r)}}),a.language&&(n.second_best=a),n}function f(e){return v.tabReplace&&(e=e.replace(/^((<[^>]+>|\t)+)/gm,function(e,t){return t.replace(/\t/g,v.tabReplace)})),v.useBR&&(e=e.replace(/\n/g,"<br>")),e}function b(e){var t=n(e),r=a(e);if("no-highlight"!=r){var i=r?u(r,t,!0):l(t),o=c(e);if(o.length){var b=document.createElementNS("http://www.w3.org/1999/xhtml","pre");b.innerHTML=i.value,i.value=s(o,c(b),t)}i.value=f(i.value),e.innerHTML=i.value,e.className+=" hljs "+(!r&&i.language||""),e.result={language:i.language,re:i.r},i.second_best&&(e.second_best={language:i.second_best.language,re:i.second_best.r})}}function h(e){v=i(v,e)}function g(){if(!g.called){g.called=!0;var e=document.querySelectorAll("pre code");Array.prototype.forEach.call(e,b)}}function p(){addEventListener("DOMContentLoaded",g,!1),addEventListener("load",g,!1)}function d(e,t){var r=E[e]=t(this);r.aliases&&r.aliases.forEach(function(t){m[t]=e})}function N(e){return E[e]||E[m[e]]}var v={classPrefix:"hljs-",tabReplace:null,useBR:!1,languages:void 0},E={},m={};this.highlight=u,this.highlightAuto=l,this.fixMarkup=f,this.highlightBlock=b,this.configure=h,this.initHighlighting=g,this.initHighlightingOnLoad=p,this.registerLanguage=d,this.getLanguage=N,this.inherit=i,this.IR="[a-zA-Z][a-zA-Z0-9_]*",this.UIR="[a-zA-Z_][a-zA-Z0-9_]*",this.NR="\\b\\d+(\\.\\d+)?",this.CNR="(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)",this.BNR="\\b(0b[01]+)",this.RSR="!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~",this.BE={b:"\\\\[\\s\\S]",r:0},this.ASM={cN:"string",b:"'",e:"'",i:"\\n",c:[this.BE]},this.QSM={cN:"string",b:'"',e:'"',i:"\\n",c:[this.BE]},this.CLCM={cN:"comment",b:"//",e:"$"},this.CBLCLM={cN:"comment",b:"/\\*",e:"\\*/"},this.HCM={cN:"comment",b:"#",e:"$"},this.NM={cN:"number",b:this.NR,r:0},this.CNM={cN:"number",b:this.CNR,r:0},this.BNM={cN:"number",b:this.BNR,r:0},this.REGEXP_MODE={cN:"regexp",b:/\//,e:/\/[gim]*/,i:/\n/,c:[this.BE,{b:/\[/,e:/\]/,r:0,c:[this.BE]}]},this.TM={cN:"title",b:this.IR,r:0},this.UTM={cN:"title",b:this.UIR,r:0}};hljs.registerLanguage("javascript",function(e){return{aliases:["js"],k:{keyword:"in if for while finally var new function do return void else break catch instanceof with throw case default try this switch continue typeof delete let yield const class",literal:"true false null undefined NaN Infinity",built_in:"eval isFinite isNaN parseFloat parseInt decodeURI decodeURIComponent encodeURI encodeURIComponent escape unescape Object Function Boolean Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError Number Math Date String RegExp Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray ArrayBuffer DataView JSON Intl arguments require"},c:[{cN:"pi",b:/^\s*('|")use strict('|")/,r:10},e.ASM,e.QSM,e.CLCM,e.CBLCLM,e.CNM,{b:"("+e.RSR+"|\\b(case|return|throw)\\b)\\s*",k:"return throw case",c:[e.CLCM,e.CBLCLM,e.REGEXP_MODE,{b:/</,e:/>;/,r:0,sL:"xml"}],r:0},{cN:"function",bK:"function",e:/\{/,c:[e.inherit(e.TM,{b:/[A-Za-z$_][0-9A-Za-z$_]*/}),{cN:"params",b:/\(/,e:/\)/,c:[e.CLCM,e.CBLCLM],i:/["'\(]/}],i:/\[|%/},{b:/\$[(.]/},{b:"\\."+e.IR,r:0}]}}),hljs.registerLanguage("css",function(e){var t="[a-zA-Z-][a-zA-Z0-9_-]*",r={cN:"function",b:t+"\\(",e:"\\)",c:["self",e.NM,e.ASM,e.QSM]};return{cI:!0,i:"[=/|']",c:[e.CBLCLM,{cN:"id",b:"\\#[A-Za-z0-9_-]+"},{cN:"class",b:"\\.[A-Za-z0-9_-]+",r:0},{cN:"attr_selector",b:"\\[",e:"\\]",i:"$"},{cN:"pseudo",b:":(:)?[a-zA-Z0-9\\_\\-\\+\\(\\)\\\"\\']+"},{cN:"at_rule",b:"@(font-face|page)",l:"[a-z-]+",k:"font-face page"},{cN:"at_rule",b:"@",e:"[{;]",c:[{cN:"keyword",b:/\S+/},{b:/\s/,eW:!0,eE:!0,r:0,c:[r,e.ASM,e.QSM,e.NM]}]},{cN:"tag",b:t,r:0},{cN:"rules",b:"{",e:"}",i:"[^\\s]",r:0,c:[e.CBLCLM,{cN:"rule",b:"[^\\s]",rB:!0,e:";",eW:!0,c:[{cN:"attribute",b:"[A-Z\\_\\.\\-]+",e:":",eE:!0,i:"[^\\s]",starts:{cN:"value",eW:!0,eE:!0,c:[r,e.NM,e.QSM,e.ASM,e.CBLCLM,{cN:"hexcolor",b:"#[0-9A-Fa-f]+"},{cN:"important",b:"!important"}]}}]}]}]}}),hljs.registerLanguage("xml",function(){var e="[A-Za-z0-9\\._:-]+",t={b:/<\?(php)?(?!\w)/,e:/\?>/,sL:"php",subLanguageMode:"continuous"},r={eW:!0,i:/</,r:0,c:[t,{cN:"attribute",b:e,r:0},{b:"=",r:0,c:[{cN:"value",v:[{b:/"/,e:/"/},{b:/'/,e:/'/},{b:/[^\s\/>]+/}]}]}]};return{aliases:["html"],cI:!0,c:[{cN:"doctype",b:"<!DOCTYPE",e:">",r:10,c:[{b:"\\[",e:"\\]"}]},{cN:"comment",b:"<!--",e:"-->",r:10},{cN:"cdata",b:"<\\!\\[CDATA\\[",e:"\\]\\]>",r:10},{cN:"tag",b:"<style(?=\\s|>|$)",e:">",k:{title:"style"},c:[r],starts:{e:"</style>",rE:!0,sL:"css"}},{cN:"tag",b:"<script(?=\\s|>|$)",e:">",k:{title:"script"},c:[r],starts:{e:"</script>",rE:!0,sL:"javascript"}},{b:"<%",e:"%>",sL:"vbscript"},t,{cN:"pi",b:/<\?\w+/,e:/\?>/,r:10},{cN:"tag",b:"</?",e:"/?>",c:[{cN:"title",b:"[^ /><]+",r:0},r]}]}}),hljs.registerLanguage("coffeescript",function(e){var t={keyword:"in if for while finally new do return else break catch instanceof throw try this switch continue typeof delete debugger super then unless until loop of by when and or is isnt not",literal:"true false null undefined yes no on off",reserved:"case default function var void with const let enum export import native __hasProp __extends __slice __bind __indexOf",built_in:"npm require console print module exports global window document"},r="[A-Za-z$_][0-9A-Za-z$_]*",n=e.inherit(e.TM,{b:r}),a={cN:"subst",b:/#\{/,e:/}/,k:t},i=[e.BNM,e.inherit(e.CNM,{starts:{e:"(\\s*/)?",r:0}}),{cN:"string",v:[{b:/'''/,e:/'''/,c:[e.BE]},{b:/'/,e:/'/,c:[e.BE]},{b:/"""/,e:/"""/,c:[e.BE,a]},{b:/"/,e:/"/,c:[e.BE,a]}]},{cN:"regexp",v:[{b:"///",e:"///",c:[a,e.HCM]},{b:"//[gim]*",r:0},{b:"/\\S(\\\\.|[^\\n])*?/[gim]*(?=\\s|\\W|$)"}]},{cN:"property",b:"@"+r},{b:"`",e:"`",eB:!0,eE:!0,sL:"javascript"}];return a.c=i,{k:t,c:i.concat([{cN:"comment",b:"###",e:"###"},e.HCM,{cN:"function",b:"("+r+"\\s*=\\s*)?(\\(.*\\))?\\s*\\B[-=]>",e:"[-=]>",rB:!0,c:[n,{cN:"params",b:"\\(",rB:!0,c:[{b:/\(/,e:/\)/,k:t,c:["self"].concat(i)}]}]},{cN:"class",bK:"class",e:"$",i:/[:="\[\]]/,c:[{bK:"extends",eW:!0,i:/[:="\[\]]/,c:[n]},n]},{cN:"attribute",b:r+":",e:":",rB:!0,eE:!0,r:0}])}}),hljs.registerLanguage("json",function(e){var t={literal:"true false null"},r=[e.QSM,e.CNM],n={cN:"value",e:",",eW:!0,eE:!0,c:r,k:t},a={b:"{",e:"}",c:[{cN:"attribute",b:'\\s*"',e:'"\\s*:\\s*',eB:!0,eE:!0,c:[e.BE],i:"\\n",starts:n}],i:"\\S"},i={b:"\\[",e:"\\]",c:[e.inherit(n,{cN:null})],i:"\\S"};return r.splice(r.length,0,a,i),{c:r,k:t,i:"\\S"}});