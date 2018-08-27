var timer;
var counter = 0;
var startTime;
const POMO_SECONDS = 5;
document.addEventListener('DOMContentLoaded', function() {
        setSeconds(counter);
        setRestSeconds(counter);
//        var button = document.getElementById('btn');
//        if(!button) {
//            return;
//        }
        document.getElementById('btn').addEventListener('click', function(e) {
            toggleBtnFunction();
            window.addEventListener('beforeunload', beforeUnloadHandler);
        });
        document.getElementById('pomo_form').addEventListener('submit', function(e) {
            window.removeEventListener('beforeunload', beforeUnloadHandler);
        });
    }
);

var beforeUnloadHandler = function(e) {
    let msg = '入力したデータが消えてしまう可能性があります．'
    e.returnValue = msg;
    return msg;
}

function toggleBtnFunction() {
    var button = document.getElementById('btn');
    if(button.value == 'Start') {
        startTimer();
        button.value = 'Stop';
    } else if(button.value == 'Stop') {
        stopTimer();
        button.value = 'ReStart';
    } else if(button.value == 'ReStart') {
        restartTimer();
        button.value = 'Stop';
    }
}

function startTimer() {
    timer = setInterval(countTimer, 1000);
    setStartTime();
    // now を id=start-timeのvalueに設定する。
}

function finishTimer() {
    stopTimer();
    setEndTime();
    setPassageSeconds();
    window.alert('おつかれさま！');
    // 通知する処理を入れる．
}

function setStartTime() {
    startTime = new Date().toString();
    var startTimeInput = document.getElementById('start_time');
    startTimeInput.value = startTime;
}

function stopTimer() {
    clearInterval(timer);
    setEndTime();
    setPassageSeconds();
}

function setRestSeconds(passageSeconds) {
    var restInput = document.getElementById('rest-time');
    if(!restInput) {
        return;
    }
    restInput.textContent = (POMO_SECONDS - passageSeconds) || 0;
}

function restartTimer() {
    timer = setInterval(countTimer, 1000);
}

function countTimer() {
    if(counter == POMO_SECONDS) {
        finishTimer();
        return;
    }
    counter++;
    setSeconds(counter);
    setRestSeconds(counter);
}

function setSeconds(passageSeconds) {
    var passageInput = document.getElementById('passage_seconds');
    if (!passageInput) {
        return;
    }
    passageInput.value = passageSeconds;
}


function setEndTime() {
    var stopTimeInput = document.getElementById('end_time');
    stopTimeInput.value = new Date().toString();
}

function setPassageSeconds() {
    var passageInput = document.getElementById('passage_seconds');
    if (!passageInput) {
        return;
    }
    passageInput.value = counter;
}

function confirmLeave() {
    window.confirm('このウェブページを離脱しますか？')
}
