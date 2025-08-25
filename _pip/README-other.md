# some other specialty


## TTS on macOS

[Text to Speech on macOS with Piper | ThoughtAsylum](https://www.thoughtasylum.com/2025/08/25/text-to-speech-on-macos-with-piper/)


### piper-tts (via pip)

```
python3 -m pip install piper-tts --user '--break-system-packages'
```

Available voices:

- https://piper.ttstool.com
- [Piper Voice Samples](https://rhasspy.github.io/piper-samples/)
  - Can also manually download from  https://huggingface.co/rhasspy/piper-voices/tree/main

### Installing pan

Homebrew

```
brew tap sylumer/tap
brew install sylumer/tap/pan
```


#### Configurating


<https://github.com/OHF-Voice/piper1-gpl/blob/main/docs/CLI.md>

Downloading voices

```shell
mkdir -p ~/projects/ai/piper/voices/en_US
cd ~/projects/ai/piper/voices/en_US

# list voices
python3 -m piper.download_voices

# download voice
python3 -m piper.download_voices en_US-lessac-medium

# and another
cd ../en_GB
python3 -m piper.download_voices en_GB-aru-medium
```


`.panrc`

```
# MODEL="$HOME/projects/ai/piper/voices/en_US/en_US-lessac-high"
MODEL="$HOME/projects/ai/piper/voices/en_GB/en_GB-aru-medium"
VOICE=10
QUALITY=2
```
