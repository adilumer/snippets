/*****************************************************************
*  09/10/2021                                           Adil Umer                                                                   
*  Product of a Saturday afternoon.
*
*  Function arguments:                          
*      dataList: Array of arrays or objects to be exported.
*      opts: options ¯\_(ツ)_/¯ (object)
*          opts.fileName:  File name to suggest when exported
*                          file is being saved.
*          opts.headers:   Array of headers of the csv file.
*          opts.fields:    If export items are arrays, array of
*                          indices, else an array of keys to be 
*                          exported.
*                          OR an object having callbacks for each
*                          value.
*          opts.noHeaders: If export items are objects and no
*                          header array is supplied, csv will 
*                          have its first row from keys of the 
*                          object, unless this is set to true.*                                                               
*          opts.ngObject:  Set this to true if you dont want the 
*                          internal variables assigned by angular 
*                          being exported accidentally, especially 
*                          when the fields param isn't defined.
*
*  It is highly recommended to provide fields if an array of 
*  objects is being exported to prevent issues like column 
*  mismatch. It is not necessary if your objects aren't 
*  heterogeneous.
*  
*  The fields arraya can take strings like "someKey.someSubkey"
*  if the data you want to export has nested objects. 
*
*  
*
******************************************************************/

const isBrowser = typeof window !== 'undefined' && typeof window.document !== 'undefined';
const isNode = typeof process !== 'undefined' && process.versions != null && process.versions.node != null;

function exportToCsv(dataList, opts, callback) {
  function processVal(val, key){
    // If a function is defined for the given value...  
    if (!Array.isArray(opts.fields) && typeof(opts.fields?.[key]) == 'function'){
      return opts.fields[key](val);
    }
    
    if (val === null || val === undefined) return "";

    // Item logic, stringify or format if date.
    var innerValue = val.toString();
    if (typeof(val) == 'object') innerValue = JSON.stringify(val);
    if (val instanceof Date) innerValue = val.toLocaleString();

    // Escaping necessary characters
    var result = innerValue.replace(/"/g, '""');
    if (result.search(/("|,|\n)/g) >= 0) result = `"${result}"`;

    return result;
  }
  
  function getValRecursive(obj, key){
    if(typeof(obj) != "object" || !key?.length) return null;

    var keyArr = key.split('.');
    var result = obj;
    for (var i = 0; i < keyArr.length; i++){
      result = result?.[keyArr[i]];
      if(typeof(result) != "object") return result;
    }
    return result;
  }

  function processObject (obj) {
    var finalVal = "";
    if(opts.fields) {
      var fields = Array.isArray(opts.fields) ? opts.fields : Object.keys(opts.fields);
      // keep the order and prevent problems due to null properties.
      // If only specific parameters need to be exported.
      fields.forEach((val, idx)=>{
        var addVal = processVal(obj[val], val);
        if(val.includes?.('.')) addVal = getValRecursive(obj, val);
        finalVal += `${addVal},`;
      });
    }else{
      for (var j in obj) {
        if(opts.ngObject && j == '$$hashKey') continue;
        finalVal += `${processVal(obj[j], j)},`;
      }
    }
    // remove last comma before appending the text.
    var line = `${finalVal.substring(0, finalVal.length - 1)}\n`;
    return line;
  };

  function processRow(obj, isHeader) {
    var finalVal = '';
    var exportIndices = null;

    if(!isHeader){
      if (opts.fields && Array.isArray(opts.fields)) exportIndices = opts.fields;
      else if (typeof(opts.fields) == 'object') {
        exportIndices = Object.keys(opts.fields).map((v, i)=>{
          return Number(v);
        });
      }
    }

    for (var j = 0; j < obj.length; j++) {
      // If only specific parameters need to be exported.
      if (exportIndices && !exportIndices.includes(j)) continue;
      var result = processVal(obj[j], j);
      if (j > 0) finalVal += ',';
      finalVal += result;
    }
    return finalVal + '\n';
  };

  var csvString = "";

  if (opts.headers){
    csvString += processRow(opts.headers, true);
  }else if (!Array.isArray(dataList[0]) && !opts.noHeaders){
    // If the file isn't specifically expected to be headerless,
    // and there are no headers specified, add field names as headers...
    var header = opts.fields || Object.keys(dataList[0]).filter((m, i)=>{ return !opts.ngObject || m != '$$hashKey' });
    csvString += processRow(header);
  }

  for (var i = 0; i < dataList.length; i++) {
    var item = (opts.ngObject && typeof(angular?.copy) == "function" ) ? angular.copy(dataList[i]) : dataList[i];
    csvString += Array.isArray(item) ? processRow(item) : processObject(item);
    if(i >= dataList.length - 1){
      callback?.(csvString);
    }
  }

  if(isBrowser){
    var blob = new Blob([csvString], { type: "text/csv;charset=utf-8;" });
    if (navigator.msSaveBlob) {
      // IE 10+
      navigator.msSaveBlob(blob, opts.fileName || "export.csv");
    } else {
      var link = document.createElement("a");
      if (link.download !== undefined) {
        // feature detection
        // Browsers that support HTML5 download attribute
        var url = URL.createObjectURL(blob);
        link.setAttribute("href", url);
        link.setAttribute("download", opts.fileName || "export.csv");
        link.style.visibility = "hidden";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
      } else{
        // Fallback...
        var encodedURI = encodeURI(csvString);
        window.open(encodedURI);
      }
    }
  }
}
  

if (isBrowser){
  window.exportToCsv = exportToCsv;  
}else if (isNode){
  module.exports = { exportToCsv }
}