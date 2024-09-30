SynthDef(\synthstring, {
    |freq = 440, amp = 0.3, pan = 0, dur = 1|
    var sound, env;
    sound = SinOsc.ar(freq, 0, amp);
    env = EnvGen.kr(Env.perc(0.01, 1.5), doneAction: 2);
    Out.ar(0, Pan2.ar(sound * env, pan));
}).add();

SynthDef(\synthstring2, {
    |freq = 440, dur = 1, amp = 0.27, pan = 0|
    var sound, env;
    sound = SinOsc.ar(freq, 0, amp * 0.5);
    env = EnvGen.kr(Env.perc(0.01, 1.5), doneAction: 2);
    Out.ar(0, Pan2.ar(sound * env, pan));
}).add();

SynthDef(\warmpiano, {
    |freq = 440, amp = 0.3, dur = 0.5, pan = 0|
    var sound, env;
    sound = SinOsc.ar(freq, 0, amp * 0.5) + SinOsc.ar(freq * 1.013, 0, amp * 0.2);
    env = EnvGen.kr(Env.perc(0.01, 2.5), doneAction: 2);
    Out.ar(0, Pan2.ar(sound * env, pan));
}).add();

SynthDef(\bass, {
    |freq = 440, amp = 0.045, dur = 0.25, pan = 0 |
    var sound, env, eq;
    sound = Saw.ar(freq, amp * 0.3) + SinOsc.ar(freq * 2, amp * 0.1) + SinOsc.ar(freq * 0.5, amp * 0.1);
    eq = LPF.ar(sound, 41);
    env = EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2);
    Out.ar(0, Pan2.ar(eq * env, pan));
}).add();

SynthDef(\sawmelowpass, {
    |freq = 440, amp = 0.7, dur = 4, pan = -1|
    var sound, env, eq, lows;
    sound = Saw.ar(freq);
    eq = LPF.ar(sound, 300);
    lows = LPF.ar(sound, 150);
    env = EnvGen.kr(Env.perc(0.1, 14), doneAction: 2);
    Out.ar(0, Pan2.ar((eq + lows) * env * amp, pan));
}).add();

SynthDef(\sawmelowpass2, {
    |freq = 1108.73, amp = 0.7, dur = 4, pan = 1|
    var sound, env, eq, lows;
    sound = Saw.ar(freq);
    eq = LPF.ar(sound, 300);
    lows = LPF.ar(sound, 150);
    env = EnvGen.kr(Env.perc(0.1, 14), doneAction: 2);
    Out.ar(0, Pan2.ar((eq + lows) * env * amp, pan));
}).add();

~tempo = 1;

~sound1pattern = [138.59, 123.47, 164.81, 220];
~sound2pattern = [349.23, 369.99, 415.3, 369.99];
~sound3pattern = [554.37, 830.61, 830.61, 739.99, 739.99, 830.61, 987.77, 830.61, 739.99];
~sound4pattern = [138.59, 138.59, 138.59, 138.59, 123.47, 123.47, 123.47, 123.47,
                  164.81, 164.81, 164.81, 164.81, 220, 220, 220, 207.65];

Ppar([
    Pbind(
        \instrument, \synthstring,
        \freq, Pseq(~sound1pattern, inf),
        \amp, 0.3,
        \dur, Pn(~tempo, inf),
        \pan, 0
    ),
    Pbind(
        \instrument, \synthstring2,
        \freq, Pseq(~sound2pattern, inf),
        \amp, 0.9,
        \dur, Pn(~tempo, inf),
        \pan, 0
    ),
    Pbind(
        \instrument, \warmpiano,
        \freq, Pseq(~sound3pattern, inf),
        \dur, Pseq([~tempo / 2,~tempo / 2,~tempo / 2,~tempo / 2,~tempo / 2, ~tempo / 2,~tempo / 4,~tempo / 4], inf),
        \amp, 0.3,
        \pan, 0.2
    ),
    Pbind(
        \instrument, \bass,
        \freq, Pseq(~sound4pattern, inf),
        \amp, 0.3,
        \dur, Pn(~tempo / 4, inf),
        \pan, 0
    ),
    Pbind(
        \instrument, \sawmelowpass,
        \freq, 1661.22 / 2,
        \amp, 0.7,
        \dur, Pn(~tempo * 4, inf),
        \pan, -1
    ),
    Pbind(
        \instrument, \sawmelowpass2,
        \freq, 1108.73,
        \amp, 0.7,
        \dur, Pn(~tempo * 4, inf),
        \pan, 1
    )
]).play;


