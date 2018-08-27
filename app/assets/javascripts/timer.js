var timer;
var counter = 0;
var startTime;
const POMO_SECONDS = 1500;
document.addEventListener('DOMContentLoaded', function() {
        setSeconds(counter);
        setRestSeconds(counter);
        let control_btn = document.getElementById('start-stop-btn');
        if(!control_btn) {
            return;
        }
        control_btn.addEventListener('click', function() {
            toggleBtnFunction();
            window.addEventListener('beforeunload', beforeUnloadHandler);
            document.getElementById('pomo_form').addEventListener('submit', function() {
                window.removeEventListener('beforeunload', beforeUnloadHandler);
            });
        });


    }
);

var beforeUnloadHandler = function(event) {
    event.returnValue = '入力したデータが消えてしまう可能性があります．';
}

function toggleBtnFunction() {
    var control_btn = document.getElementById('start-stop-btn');
    var submit_btn = document.getElementById('submit-btn');
    if(control_btn.value == 'Start') {
        startTimer();
        control_btn.value = 'Stop';
        submit_btn.setAttribute('disabled', 'disabled');
    } else if(control_btn.value == 'Stop') {
        stopTimer();
        control_btn.value = 'ReStart';
        submit_btn.removeAttribute('disabled');
    } else if(control_btn.value == 'ReStart') {
        restartTimer();
        control_btn.value = 'Stop';
        submit_btn.setAttribute('disabled', 'disabled');
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
    restInput.textContent = restTime(POMO_SECONDS - passageSeconds) || 0;
}

function restTime(restSeconds) {
    let minutes = restSeconds / 60 | 0;
    let seconds = restSeconds % 60;
    return minutes + '分' + seconds + '秒';
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
