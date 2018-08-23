document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('btn').addEventListener('click', function() {
            toggleBtnFunction();
        })
    }
)

function toggleBtnFunction() {
    var button = document.getElementById('btn');
    if(button.value == 'Start' || button.value == 'ReStart') {
        button.value = 'Stop';
        button.className = 'stop-timer';
        startTimer();
    } else if(button.value == 'Stop') {
        stopTimer();
        button.value = 'ReStart';
        button.className = 'start-timer';
    }
}

function startTimer() {

}

function stopTimer() {

}