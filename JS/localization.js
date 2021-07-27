var sysLang = GLOBAL_DEFAULT_LANG;
var languages = {
  en: {
    "EXAMPLE": "Example"
  }
}

async function localeLoaded(){
    if(languages[sysLang]){
        return true;
    }else{
        await sleep(2000);
        return languages[sysLang] != undefined;
    }
}

function localize(str){

    if (languages[sysLang]){
        var args = Array.prototype.slice.call(arguments, 1);
        var key = languages[sysLang][str] || `**${str}**`; //|| languages[GLOBAL_VARS.DEFAULT_LANG][str] 
        
        return key.replace(/{(\d+)}/g, function(match, number) { 
            return typeof args[number] != 'undefined' ? args[number] : match;
        });
    }
}
