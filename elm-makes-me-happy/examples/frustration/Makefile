
TARGET := ../../frustration.js
SOURCE := src/Frustration.elm

all: ${TARGET}

type:
	elm make --output foo.js src/FrustrationTypes.elm

${TARGET}: ${SOURCE}
	elm make --output $@ ${SOURCE}

clean:
	rm -f ${TARGET}

