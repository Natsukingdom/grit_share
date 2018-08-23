var timer;
var counter = 60 * 25
document.addEventListener('DOMContentLoaded', function() {
        setSeconds(counter);
        document.getElementById('btn').addEventListener('click', function() {
            toggleBtnFunction();
        })
    }
)

function toggleBtnFunction() {
    var button = document.getElementById('btn');
    if(button.value == 'Start' || button.value == 'ReStart') {
        startTimer();
        button.value = 'Stop';
        button.className = 'stop-timer';
    } else if(button.value == 'Stop') {
        stopTimer();
        button.value = 'ReStart';
        button.className = 'start-timer';
    }
}


function startTimer() {
    timer = setInterval(function() {
        counter--;
        setSeconds(counter);
    }, 1000)
}

function stopTimer() {
    clearInterval(timer);
}

function setSeconds(restSeconds) {
    var seconds = document.getElementById('seconds')
    seconds.textContent = restSeconds;
}
