
function getADate(from, to) {
  var start = from || (new Date().addDays(-2));
  var end = to || (new Date()); 
  var t = new Date(start.getTime() + Math.random() * (end.getTime() - start.getTime()));
  var str = t.toISOString().replace('T', ' ').substring(0, 19);
  return str;
}

function basicAuthString(uname, pwd){
  let data = `${uname}:${pwd}`;
  let buff = new Buffer.from(data);
  let encoded = "Basic "+buff.toString('base64');
  return encoded;
}

function generateToken(length) {
  var result = '';
  var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  var charactersLength = characters.length;
  for (var i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  return result;
}

// Replace Turkish-specific characters with their standard Latin counterparts.
function makeSortString(s) {
  if (!s) return "";
  var translate_tr = /[ĞÜŞİÖÇğüşıöç]/g;
  var translate = {
    "ı": "i", "ö": "o", "ü": "u",
    "İ": "I", "Ö": "O", "Ü": "U",
    "Ş": "S", "ş": "s", "Ğ": "G",
    "ğ": "g", "Ç": "C", "ç": "c"
  };
  return ( s.replace(translate_tr, function(match) { 
    return translate[match]; 
  }) );
}

//Express
function getIPFromReq(req, asIPv6) {
  //req.headers['cf-connecting-ip'] get cloudflare connecting ip 
  let ip = req.headers['cf-connecting-ip'] || req.headers['x-forwarded-for'] || req.connection.remoteAddress || '';
  let m = ip.match(asIPv6 ? RGX_IPV6 : RGX_IPV4);
  return m ? m[0] : ip;
}

function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function sleep(n) {
  msleep(n*1000);
}

function msleep(n) {
  Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, n);
}

function nonblockingDelay(ms) {
  new Promise(resolve => setTimeout(resolve, ms))
};

function paddedGen(a, n){
  return a.toString().padStart(n || 2, '0');
}

function readableDateTime(){
  var t = new Date();
  var str = `${paddedGen(t.getHours())}:${paddedGen(t.getMinutes())}:${paddedGen(t.getSeconds())} ${paddedGen(t.getDate())}.${paddedGen(t.getMonth()+1)}.${t.getFullYear()}`;
  return str;
}

function secondsToReadableTime(sec){
  d = Number(sec);
  var seconds = paddedGen(Math.floor(d % 3600 % 60));
  var minutes = paddedGen(Math.floor(d % 3600 / 60));
  var hours = paddedGen(Math.floor(d / 3600));

  return `${hours}:${minutes}:${seconds}`;
}

if (!String.format) {
  String.format = function(format) {
    var args = Array.prototype.slice.call(arguments, 1);
    return format.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number] 
        : match
      ;
    });
  };
}