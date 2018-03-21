.PHONY: *
docker:
	@docker build --rm -t identakid/opencv:3.4.1 .

