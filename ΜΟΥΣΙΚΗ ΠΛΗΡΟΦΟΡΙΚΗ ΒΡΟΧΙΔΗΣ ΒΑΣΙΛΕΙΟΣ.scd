Server.default.boot;
//ήχοι//

SynthDef(\chord, {
|freq = 440, amp = 0.5, dur = 2, pan = 0|
var sawSound, sinSound, sound, env;
sawSound = Mix.new([

		Saw.ar(freq / 2, 0.2),

		Saw.ar((freq * 1.5) / 2, 0.2),

		Saw.ar(freq, 0.2)
]);
sinSound = Mix.new([
SinOsc.ar(freq / 2, 0, 0.2),

		SinOsc.ar((freq * 1.5) / 2, 0, 0.2),

		SinOsc.ar(freq, 0, 0.2)
 ]);
sound = sawSound + sinSound;
 env = EnvGen.kr(Env.perc(0.01, 2.0), doneAction: 2);
Out.ar(0, Pan2.ar(sound * env * amp, pan));
}).add;

SynthDef(\melody, {
|freq =  440, amp = 0.3, dur = 0.5, pan = 0|
 var sound, env;


	sound = SinOsc.ar(freq, 0, amp);

	env = EnvGen.kr(Env.perc(0.01, 0.9), doneAction: 2);

	Out.ar(0, Pan2.ar(sound * env, pan));
}).add;

SynthDef(\ixos3, {

	|freq = 987.77, amp = 0.2, dur = 2, pan = -1|

	var sound, env;

	sound = SinOsc.ar(freq, 0, amp);

	env = EnvGen.kr(Env.perc(0.01, dur - 0.01), doneAction: 2);

	Out.ar(0, Pan2.ar(sound * env * amp, pan));
}).add;
SynthDef(\ixos4, {

|amp = 0.23, freq = 440, dur = 2 , pan = 1 |
var sound, env;

sound = VarSaw.ar(freq, 0, 0.5, amp);
env = EnvGen.kr(Env.linen(0.01, dur - 0.01, 0.1), doneAction: 2);

	Out.ar(0, Pan2.ar(sound * env * amp, pan));
}).add();

SynthDef(\ixos5, {

	|freq = 440, amp = 0.1, dur = 0.5, pan = 0 |

	var sound, env;

	sound = LFTri.ar(freq, 0, amp);

	env = EnvGen.kr(Env.perc(0.01, 0.9), doneAction: 2);

Out.ar(0, Pan2.ar(sound * env, pan));
}).add();

SynthDef(\string, {

	|freq = 440,  amp = 0.2, dur = 1, pan = 0|

	var sound, env;

sound = Blip.ar(freq, 2, amp);

	env = EnvGen.kr(Env.perc(0.1, 2.0), doneAction: 2);

	Out.ar(0, Pan2.ar(sound * env, pan));
}).add();

~tempo = 0.9;
~chordpattern = [220, 261.63, 349.23, 293.66] / 2 * 1.12246;
~chordpatternduration = ~chordpattern.size * (~tempo * 2);
~loops = 2;
~telos = 120;

(

//δομή κομματιού //

Routine({
    var chordplayer, melodyplayer, ixos3player, ixos4player, ixos5player, stringplayer;

chordplayer = Pbind(
 \instrument, \chord,
 \freq, Pseq(~chordpattern, inf),
 \dur, Pn(~tempo * 2, inf),
 \amp, 0.5,
 \pan, 0
    ).play;

(~loops * ~chordpatternduration).wait;
stringplayer = Pbind(
 \instrument, \string,
  \freq, Pseq([369.99, 329.628, 369.99, 246.94], inf),
 \dur, Pn(~tempo * 2, inf),
 \amp, 0.2,
  \pan, -0.3
    ).play;

	(~loops * ~chordpatternduration).wait;
melodyplayer = Pbind(
 \instrument, \melody,
 \freq, Pseq([659.255, 440, 659.255, 440, 261.626, 440, 261.63, 293.665] * 1.12246, inf),
 \dur, Pn(~tempo / 2, inf),
 \amp, 0.3,
 \pan, 0
    ).play;

    (~loops * ~chordpatternduration).wait;
ixos3player = Pbind(
 \instrument, \ixos3,
 \freq, Pseq([987.77, 1046.50] * 1.122, inf),
 \dur, Pseq([~tempo * 2, ~tempo * 2], inf),
 \amp, 0.2,
  \pan, -1
    ).play;

   (~loops * ~chordpatternduration).wait;
ixos4player = Pbind(
 \instrument, \ixos4,
 \freq, Pseq([659.25, 440] * 1.122, inf),
 \dur, Pseq([~tempo * 2, ~tempo * 2], inf),
 \amp, 0.2,
  \pan, 1
    ).play;
 (~loops * ~chordpatternduration).wait;
ixos5player = Pbind(
 \instrument, \ixos5,
 \freq, Pseq([1108.73, 1108.73, 1174.66, 1174.66, 1760, 1568, 1479.98, 987.767], inf),
  \dur, Pn(~tempo / 2, inf),
 \amp, 0.1,
 \pan, 0
    ).play;

	(~loops * ~chordpatternduration).wait;


	chordplayer.stop;

	stringplayer.stop;

	melodyplayer.stop;

	ixos3player.stop;

	ixos4player.stop;

	ixos5player.stop;
	1.2.wait;

}).play;
)
