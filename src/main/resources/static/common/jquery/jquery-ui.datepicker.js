/* jQuery calendar extension. */
$(function() {
    $(".Date").datepicker({
    	changeMonth: true, 
        changeYear: true,
    	showButtonPanel: true,
    	yearRange: "-100:+0",
    	dateFormat: "yy-mm-dd"
    });
    $("#Date1").datepicker({
    	changeMonth: true, 
        changeYear: true,
    	showButtonPanel: true,
    	yearRange: "-100:+0",
    	dateFormat: "yy-mm-dd"
    });
    $("#date1").datepicker({
    	changeMonth: true, 
        changeYear: true,
    	showButtonPanel: true,
    	yearRange: "-100:+0",
	    currentText: '오늘 날짜', // Today
	    closeText: '닫기', // Done
	    dateFormat: "yy-mm-dd",								    
    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    });
    $("#date2").datepicker({
    	changeMonth: true, 
        changeYear: true,
    	showButtonPanel: true,
    	yearRange: "-100:+0",
	    currentText: '오늘 날짜', // Today
	    closeText: '닫기', // Done
	    dateFormat: "yy-mm-dd",								    
    	dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
        monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    });
});