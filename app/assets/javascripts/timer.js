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
    if(button.value == 'Start') {
        startTimer();
        button.value = 'Stop';
    } else if(button.value == 'Stop') {
        stopTimer();
        button.value = 'ReStart';
    } else if(button.value == 'Restart') {
        restartTimer();
        button.value = 'Stop';
    }
}


function startTimer() {
    timer = setInterval(countTimer, 1000)
    // now を id=start-timeのvalueに設定する。
}

function stopTimer() {
    clearInterval(timer);
    //
}

function setSeconds(restSeconds) {
    var seconds = document.getElementById('rest-time')
    seconds.textContent = restSeconds;
}

function restartTimer() {

}

function countTimer() {
    counter--;
    setSeconds(60 * 25 - counter);
}

function submitTimer() {

}
