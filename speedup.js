// function to use arrow keys to skip 10 seconds of a video
document.onkeydown = checkKey;

function checkKey(e) {
    e = e || window.event;

    if (e.keyCode == '37') {
       document.querySelector("video").currentTime -= 10;
    }
    else if (e.keyCode == '39') {
       document.querySelector("video").currentTime += 10;
    }
}

// increase playback speed of a video
document.querySelector("video").playbackRate = 2.5;



