
var audio = new Audio();
audio.src='wihih3.wav';
audio.controls = true;
audio.loop = true;
audio.autoplay = false;


context = new AudioContext(); // AudioContext object instance
analyser = context.createAnalyser(); // AnalyserNode method
canvas = document.getElementById('analyser_render');
ctx = canvas.getContext('2d');

function frameLooper(){
  window.requestAnimationFrame(frameLooper);
  fbc_array = new Uint8Array(analyser.frequencyBinCount);
  analyser.getByteFrequencyData(fbc_array);
  ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the canvas
  ctx.fillStyle = '#FFaaaa'; // Color of the bars
  bars = 150;
  for (var i = 0; i < bars; i++) {
    bar_x = i * 2;
    bar_width = 0.6;
    bar_height = -(fbc_array[i] / 2);
    //  fillRect( x, y, width, height ) // Explanation of the parameters below
    ctx.fillRect(bar_x, canvas.height, bar_width, bar_height);
  }
}


var QUAL_MUL = 25;

function FilterSample() {
  this.isPlaying = false;
  loadSounds(this, {buffer: 'wihih3.wav'});
};

FilterSample.prototype.play = function() {
  document.getElementById("play-pause-icon").className = "fa fa-stop fa-fw fa-2x";

  // Create the source.
  var source = context.createBufferSource();
  source.buffer = this.buffer;
  // Create the filter.
  var filter = context.createBiquadFilter();
  filter.type = filter.LOWPASS;
  filter.frequency.value = 5000;
  // Connect source to filter, filter to destination.
  source.connect(filter);
  filter.connect(context.destination);

  // Re-route audio playback into the processing graph of the AudioContext
  filter.connect(analyser);
  analyser.connect(context.destination);
  frameLooper();

  source[source.start ? 'start' : 'noteOn'](0);
  source.loop = true;
  // Save source and filterNode for later access.
  this.source = source;
  this.filter = filter;
};

FilterSample.prototype.stop = function() {
  document.getElementById("play-pause-icon").className = "fa fa-play fa-fw fa-2x";
  this.source.stop(0);
};

FilterSample.prototype.toggle = function() {
  this.isPlaying ? this.stop() : this.play();
  this.isPlaying = !this.isPlaying;
};

FilterSample.prototype.changeFrequency = function(element) {
  // Clamp the frequency between the minimum value (40 Hz) and half of the
  // sampling rate.
  var minValue = 40;
  var maxValue = context.sampleRate / 2;
  // Logarithm (base 2) to compute how many octaves fall in the range.
  var numberOfOctaves = Math.log(maxValue / minValue) / Math.LN2;
  // Compute a multiplier from 0 to 1 based on an exponential scale.
  var multiplier = Math.pow(2, numberOfOctaves * (element.value - 1.0));
  // Get back to the frequency value between min and max.
  this.filter.frequency.value = maxValue * multiplier;
};

FilterSample.prototype.changeQuality = function(element) {
  this.filter.Q.value = element.value * QUAL_MUL;
};

FilterSample.prototype.toggleFilter = function(element) {
  this.source.disconnect(0);
  this.filter.disconnect(0);
  // Check if we want to enable the filter.
  if (element.checked) {
    // Connect through the filter.
    this.source.connect(this.filter);
    this.filter.connect(context.destination);

  } else {
    // Otherwise, connect directly.
    this.source.connect(context.destination);
  }
};
