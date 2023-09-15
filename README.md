### alpha version!!!

<h1 align="center">
  auto-rello-it
</h1>

<p align="center">
 <img src="https://img.shields.io/badge/v0.1.1-ARI-blue?style=flat-square" alt="ari"> <img src="https://img.shields.io/badge/v3-autoIT-darkblue?style=flat-square" alt="ari">
 <img src="https://img.shields.io/badge/UI-Trello-%2bbcf?style=flat-square" alt="SASS">
</p>

## Demo video

![demo](docs/demo.gif)

<em>for version: v0.1.0</em>

## quick start

- download and install [autoIT](https://www.autoitscript.com/site/autoit/downloads/)
- clone this repo or download it.
- setup the necessary config data in **scripts/constats.au3**. which includes:
  - **$board_url** : path to your trello board.
  - **$chrome_save_dir** : path to your chrome download directory.
- warm up trello board & card before using the script (after fresh boot).
- prepare trello in white mode & left side-bar must be closed.
- must have a separate chrome window opened up.
- run the file: `main.au3`.

### Result Data Format

#### CSV file

- The ',' character, is replaced with the hexadecimal value '0x2C'
- end line (LF & CRLF) are replaced with '\n'

#### Images

- images are named by their id in data file, followed by their index in the card.

#### Notes

- If mouse tooltip showed: **Waiting...** for too long, restart the script.
- **$s -> $xl** : global static time sleep speed
- **$tf** {time factor} for network blocking actions, which is a function scoped delay factors
- after each run, **old data** saved gets **deleted**.

#### Features

- **f10** to quit the script while running
- you can use **debug** function for tooltips (basic for now but will be improved)

#### Test enviroment

- Windows 11
- Chrome (version 117)
- autoIT (version 3.3.16)
- Screen resolution: 1920x1080px

##### known issues

- sometimes last card image is not being saved.
- dont work without a chrome window opened up.
