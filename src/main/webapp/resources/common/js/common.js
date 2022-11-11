//input element : Make sure y value is normal
function checkText (y) {
  var v = y.value
  v = v.trim()
  if (y.defaultValue == v)
    if (v == '')
      return false
  return true

}

//Check if string value is normal

function checkValue (str) {
  if (str == null)
    return false
  var v = str.trim()
  if (v == '')
    return false
  return true

}

function checkMaxLength (obj) {
  var maxLength = parseInt(obj.getAttribute('maxlength'))
  if (obj.value.length > maxLength) {
    $.alert('The number of characters is limited to ' + maxLength + ' characters.')
    obj.value = obj.value.substring(0, maxLength)

  }

}

// String encoding to avoid conflict with html

function htmlEscape (str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')

}

// Restore html encoding characters

function htmlUnescape (str) {
  return str
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, '\'')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&amp;/g, '&')

}

//NULL Compare
function checkNull (string) {
  if (string == null || string == '') {
    return true
  } else {
    return false

  }

}

//length Compare

function checkLen (string) {
  if (checkNull(string) == false) {
    return string.length

  }

}

//number Compare

function onlyNum (objEv) {
  var numPattern = /([^0-9])/
  numPattern = objEv.value.match(numPattern)
  if (numPattern != null) {
    objEv.value = ''
    objEv.focus()
    return false

  }

}

//비밀번호 정규식
//특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식
function CheckPassword815 (p) {
  var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/
  return regExp.test(p)

}

//숫자와 문자 포함 형태의 6~12자리 이내의 암호 정규식
function CheckPassword612 (p) {
  var regExp = /^[A-Za-z0-9]{6,12}$/
  return regExp.test(p)

}

//이메일 정규식
function CheckEmail (e) {
  var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i
  return regExp.test(e)

}

//핸드폰 정규식

function CheckHp (h) {
  var regExp = /^\d{3}-\d{3,4}-\d{4}$/
  return regExp.test(h)

}

//일반 전화번호 정규식

function CheckPhone (p) {
  var regExp = /^\d{2,3}-\d{3,4}-\d{4}$/
  return regExp.test(p)

}

/**

 * 날짜검색(시작일 기준)

 * @param type

 * @param sdate

 * @param edate

 * @returns

 */

function checkDateSearch (type, sdate, edate) {
  var currentDate = getFormatDatePlus(new Date(), 0)
  if (type == 'now') {
    var start_date = $('.' + sdate).val(currentDate)
    var end_date = $('.' + edate).val(currentDate)
  } else if (type == '3') {
    var start_date = $('.' + sdate).val(getFormatDate(new Date(), 3))
    var end_date = $('.' + edate).val(currentDate)
  } else if (type == '7') {
    var start_date = $('.' + sdate).val(getFormatDate(new Date(), 7))
    var end_date = $('.' + edate).val(currentDate)
  } else if (type == '30') {
    var start_date = $('.' + sdate).val(getFormatDate(new Date(), 30))
    var end_date = $('.' + edate).val(currentDate)
  } else if (type == '90') {
    var start_date = $('.' + sdate).val(getFormatDate(new Date(), 90))
    var end_date = $('.' + edate).val(currentDate)
  } else if (type == '180') {
    var start_date = $('.' + sdate).val(getFormatDate(new Date(), 180))
    var end_date = $('.' + edate).val(currentDate)
  } else if (type == 'all') {
    var start_date = $('.' + sdate).val('')
    var end_date = $('.' + edate).val('')
  } else if (type.substr(0, 4) == 'year') {
    var start_date = $('.' + sdate).val(type.substr(4, 7) + '-01-01')
    var end_date = $('.' + edate).val(type.substr(4, 7) + '-12-31')

  }

}

/**

 * 날짜기준(시작일) 정의함수

 * @param date

 * @param type

 * @returns

 */

function getFormatDate (date, type) {
  if (type == 0) {
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day
  } else if (type == 3) {
    date.setDate(date.getDate() - 3)
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day
  } else if (type == 7) {
    date.setDate(date.getDate() - 7)
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day
  } else if (type == 30) {
    date.setDate(date.getDate() - 30)
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day
  } else if (type == 90) {
    date.setDate(date.getDate() - 90)
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day
  } else if (type == 180) {
    date.setDate(date.getDate() - 180)
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day
  } else if (type == 365) {
    date.setDate(date.getDate() - 365)
    var month = (1 + date.getMonth())
    month = month >= 10 ? month : '0' + month
    var day = date.getDate()
    day = day >= 10 ? day : '0' + day

  }

  var year = date.getFullYear()
  return year + '-' + month + '-' + day

}

/**
 * 날짜검색(종료일 기준)
 * @param type
 * @param sdate
 * @param edate
 * @returns
 */
function checkDateSearchPlus (type, sdate, edate) {
  var currentDatePlus = getFormatDatePlus(new Date(), 0)
  if (type == 'now') {
    var start_date = $('.' + sdate).val(currentDatePlus)
    var end_date = $('.' + edate).val(currentDatePlus)
  } else if (type == '3') {
    var start_date = $('.' + sdate).val(currentDatePlus)
    var end_date = $('.' + edate).val(getFormatDatePlus(new Date(), 3))
  } else if (type == '7') {
    var start_date = $('.' + sdate).val(currentDatePlus)
    var end_date = $('.' + edate).val(getFormatDatePlus(new Date(), 7))
  } else if (type == '30') {
    var start_date = $('.' + sdate).val(currentDatePlus)

    var end_date = $('.' + edate).val(getFormatDatePlus(new Date(), 30))

  } else if (type == '90') {

    var start_date = $('.' + sdate).val(currentDatePlus)

    var end_date = $('.' + edate).val(getFormatDatePlus(new Date(), 90))

  } else if (type == 'all') {

    var start_date = $('.' + sdate).val('')

    var end_date = $('.' + edate).val('')

  } else if (type.substr(0, 4) == 'year') {

    var start_date = $('.' + sdate).val(type.substr(4, 7) + '-01-01')

    var end_date = $('.' + edate).val(type.substr(4, 7) + '-12-31')

  }

}

/**

 * 날짜기준 (종료일) 정의함수

 * @param date

 * @param type

 * @returns

 */

function getFormatDatePlus (date, type) {

  if (type == 0) {

    var month = (1 + date.getMonth())

    month = month >= 10 ? month : '0' + month

    var day = date.getDate()

    day = day >= 10 ? day : '0' + day

  } else if (type == 3) {

    date.setDate(date.getDate() + 3)

    var month = (1 + date.getMonth())

    month = month >= 10 ? month : '0' + month

    var day = date.getDate()

    day = day >= 10 ? day : '0' + day

  } else if (type == 7) {

    date.setDate(date.getDate() + 7)

    var month = (1 + date.getMonth())

    month = month >= 10 ? month : '0' + month

    var day = date.getDate()

    day = day >= 10 ? day : '0' + day

  } else if (type == 30) {

    date.setDate(date.getDate() + 30)

    var month = (1 + date.getMonth())

    month = month >= 10 ? month : '0' + month

    var day = date.getDate()

    day = day >= 10 ? day : '0' + day

  } else if (type == 90) {

    date.setDate(date.getDate() + 90)

    var month = (1 + date.getMonth())

    month = month >= 10 ? month : '0' + month

    var day = date.getDate()

    day = day >= 10 ? day : '0' + day

  } else if (type == 365) {

    date.setDate(date.getDate() + 365)

    var month = (1 + date.getMonth())

    month = month >= 10 ? month : '0' + month

    var day = date.getDate()

    day = day >= 10 ? day : '0' + day

  }

  var year = date.getFullYear()

  return year + '-' + month + '-' + day

}

// timestamp to date

function chk_detail_timestamp (timestamp) {

  var theDate = new Date(timestamp * 1000)

  //dateString = theDate.toGMTString();

  var dateYear = theDate.getFullYear().toString()

  var dateMonth = theDate.getMonth() + 1

  var dateDate = theDate.getDate().toString()

  var dateHours = theDate.getHours().toString()

  var dateMinutes = theDate.getMinutes().toString()

  var dateSeconds = theDate.getSeconds().toString()

  if (dateMonth < 10) dateMonth = '0' + dateMonth

  if (dateDate < 10) dateDate = '0' + dateDate

  if (dateHours < 10) dateHours = '0' + dateHours

  if (dateMinutes < 10) dateMinutes = '0' + dateMinutes

  if (dateSeconds < 10) dateSeconds = '0' + dateSeconds

  dateString = dateYear + '-' + dateMonth + '-' + dateDate + ' ' + dateHours + ':' + dateMinutes + ':' + dateSeconds

  return dateString

}

//timestamp to date = YYYY-MM-DD

function chk_detail_timestamp10 (timestamp) {

  var theDate = new Date(timestamp * 1000)

  //dateString = theDate.toGMTString();

  var dateYear = theDate.getFullYear().toString()

  var dateMonth = theDate.getMonth() + 1

  var dateDate = theDate.getDate().toString()

  var dateHours = theDate.getHours().toString()

  var dateMinutes = theDate.getMinutes().toString()

  var dateSeconds = theDate.getSeconds().toString()

  if (dateMonth < 10) dateMonth = '0' + dateMonth

  if (dateDate < 10) dateDate = '0' + dateDate

  if (dateHours < 10) dateHours = '0' + dateHours

  if (dateMinutes < 10) dateMinutes = '0' + dateMinutes

  if (dateSeconds < 10) dateSeconds = '0' + dateSeconds

  dateString = dateYear + '-' + dateMonth + '-' + dateDate

  return dateString

}

//정규표현식(Regular Expression)

var REG_member_nickname = /^[A-Za-z가-힣0-9]{3,12}$/

var REG_member_email = /^\w{4,12}@\w{3,8}\.\w{1,5}$/

var REG_member_email2 = /^\w{4,12}@\w{3,8}\.\w{1,5}\.\w{1,5}$/

var REG_member_mobile = /^\d{8,13}$/

var REG_member_pwdNo = /[\d.]/

var REG_member_pwdSC = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\".]/

var REG_member_name = /^[가-힣]{2,4}|[a-zA-Z]{2,30}\s[a-zA-Z]{2,30}$/i

var REG_member_first_name = /^[a-zA-Z ,.'-]+$/i

var REG_member_last_name = /^[a-zA-Z ,.'-]+$/i

var REG_member_id = /^(?=.*[a-z])[a-z0-9]{5,20}$/i

var REG_member_account_number = /^(\d{1,})(-(\d{1,})){1,}/

var REG_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i  //이메일

var REG_name = /^[A-Za-z가-힣0-9]{2,12}$/

var REG_company_name = /^[()A-Za-z가-힣0-9]{2,12}$/

var REG_mobile = /^\d{3}\d{3,4}\d{3,4}$/

var businessNumCheck = false



/**

 * isNumber

 * @param evt

 * @returns

 */

function isNumberKey (evt) {

  var charCode = (evt.which) ? evt.which : event.keyCode

  // 숫자만 입력

  if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))

    return false

  // Textbox value

  var _value = event.srcElement.value

  // 소수점(.)이 두번 이상 나오지 못하게

  var _pattern0 = /^\d*[.]\d*$/ // 현재 value값에 소수점(.) 이 있으면 . 입력불가

  if (_pattern0.test(_value)) {

    if (charCode == 46) {

      return false

    }

  }

  return true

}

