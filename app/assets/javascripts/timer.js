document.addEventListener('DOMContentLoaded', function() {

        document.getElementById('btn').addEventListener('click', function() {
            toggleBtnFunction();
        })

        document.getElementsByClassName('start-timer').addEventListener('click', function() {
            startTimer();
        })

        document.getElementsByClassName('stop-timer').addEventListener('click', function() {
            stopTimer();
        })
    }
)

function toggleBtnFunction() {
    var button = document.getElementById('btn');
    if(button.value == 'Start') {
        button.value = 'Stop';
        button.className = 'stop-timer';
    } else if(button.value == 'Stop') {
        button.value = 'Start';
        button.className = 'start-timer';
    }
}

function startTimer() {

}