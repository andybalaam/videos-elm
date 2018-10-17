
NAME := elm-makes-me-happy
HTML := ${NAME}.html
OLD := .${HTML}.old


all:
	echo "try 'make renum' or 'make upload'"

upload:
	rsync -r \
		--exclude .git \
		./ \
		dreamhost:artificialworlds.net/presentations/${NAME}/

renum:
	mv ${HTML} ${OLD}
	./renumber < ${OLD} > ${HTML}
