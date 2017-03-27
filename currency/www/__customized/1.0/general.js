var getTime = 600;

function setTimeCounter() {
	var formatTime = formatSecond(getTime,"MM:SS");
	$('.timeCount').html(formatTime);
}

function refreshPage() {
	window.location.reload();
}

$(function() {	
	// set time counter
	setInterval(function(){ 
		getTime = getTime - 1;
		setTimeCounter();

		// refresh the page
		if(getTime == 1) {
			refreshPage();
		}
	}, 1000);
	
	// set different currency
	$('.shiny-options-group input').each(
		function(index, object) { 
			$(object).on('click', function() { getTime = $('#selectedSeconds').val(); }); 
		}
	);
	
	// reset the time
	$('#selectedSeconds').change(function() {
		getTime = $('#selectedSeconds').val();
		setTimeCounter();
	});
	
	// refresh the page
	$('#refreshNow').on('click', function() { 
		refreshPage();
	}); 	
});