.pragma library
.import "gibberish-aes-1.0.0.js" as Crypt

var GibberishAES = new Crypt.GibberishAES()
var passwdLength = 9
var passwdChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890"

function generatePasswd() {
    var str = "", pos, i
    for (i = 0; i < passwdLength; i++) {
        pos = Math.floor(Math.random() * passwdChars.length)
        str += passwdChars.charAt(pos)
    }

    return str
}

//TODO: send with additional options
function getPrivURL(note, options, callback) {
    var passwd = generatePasswd(),
    enc = GibberishAES.enc(note, passwd),
    url = "https://privnote.com/legacy/",
    http = new XMLHttpRequest(),
    params,
    has_manual_pass = options.hasOwnProperty("has_manual_pass") ? options["has_manual_pass"] : "0",
    duration_hours = options.hasOwnProperty("duration_hours") ? options["duration_hours"] : "0",
    dont_ask = options.hasOwnProperty("dont_ask") ? options["dont_ask"] : "false",
    notify_email = options.hasOwnProperty("notify_email") ? options["notify_email"] : "",
    notify_ref = options.hasOwnProperty("notify_ref") ? options["notify_ref"] : ""

    if (has_manual_pass === "true") {
        passwd = options["passwd"]
        enc = GibberishAES.enc(note, passwd)
    }

    params = "&data=" + encodeURIComponent(enc) + "&"
            + "has_manual_pass=" + has_manual_pass + "&"
            + "duration_hours=" + duration_hours + "&"
            + "dont_ask=" + dont_ask + "&"
            + "data_type=T&"
            + "notify_email=" + notify_email + "&"
            + "notify_ref=" + notify_ref;

    http.open("POST", url);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    http.setRequestHeader("Content-Length", params.length);
    http.setRequestHeader("Origin", url);
    http.setRequestHeader("Host", "privnote.com");
    http.setRequestHeader("Save-Data", "on");
    http.setRequestHeader("Accept-Language", params.length);
    http.setRequestHeader("Accept", "application/json, text/javascript, */*");
    http.setRequestHeader("User-Agent", "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Mobile Safari/537.36");
    http.setRequestHeader("Referer", url);
    http.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    http.setRequestHeader("Connection", "keep-alive");
    http.setRequestHeader("DNT", "1");

    http.onreadystatechange = function() {
        var result, privURL, ret = {};
        if (http.readyState === XMLHttpRequest.DONE) {
            if (http.status === 200) {
                result = JSON.parse(http.responseText);
                ret["result"] = true;
                ret["passwd"] = passwd;
                ret["has_manual_pass"] = result["has_manual_pass"]
                ret["link"] = result['note_link'];

            } else {
                ret["result"] = false;
                ret["desc"] = "Error: status " + http.status;
            }

            callback(ret);
        }
    }

    http.send(params);
}

function score_password(pass) {
    if (!pass) return 0;
    var score = 0, letters = {}, i, variations = {}, variationCount = 0, check;
    for (i = 0; i < pass.length; i++) {
        letters[pass[i]] = (letters[pass[i]] || 0) + 1;
        score += 5.0 / letters[pass[i]]
    }

    variations = {
        digits: /\d/.test(pass),
        lower: /[a-z]/.test(pass),
        upper: /[A-Z]/.test(pass),
        other: /\W/.test(pass)
    }

    for (check in variations) {
        variationCount += (variations[check] === true) ? 1 : 0;
    }

    score += (variationCount - 1) * 10;
    return parseInt(score)
}

function passStrength(pass) {
    var score = score_password(pass)
    if (score > 90) return "very_strong";
    else if (score > 80) return "strong";
    else if (score > 60) return "good";
    else if (score >= 30) return "weak";
    else return "very_weak";
}
