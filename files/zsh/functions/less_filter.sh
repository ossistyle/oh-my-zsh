mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}

case $kind in
	directory)
		z --git -hl --color=always --icons "$1"
		;;
	image)
		chafa "$1"
		exiftool "$1"
		;;
	vnd.openxmlformats-officedocument.spreadsheetml.sheet | vnd.ms-excel)
		in2csv "$1" | xsv table | batcat -ltsv --color=always
		;;
	text)
		bat --color=always "$1"
		;;
	*)
		lesspipe.sh "$1" | batcat --color=always --theme=
		;;
esac