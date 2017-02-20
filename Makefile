COMMAND  = docker
APP_NAME = nginx-rtmp

default :
	$(COMMAND) build -t $(APP_NAME) .

EXITED_STATUS := `${COMMAND} ps -q -f status=exited`
ALL_INSTANCES := `${COMMAND} ps -a -q`
ALL_IMAGES    := `${COMMAND} images -a -q`
ALL_DANGLING  := $($(COMMAND) images -f "dangling=true" -q)

clean :
	$(ifneq "$(EXITED_STATUS)" "", $(COMMAND) rm $(EXITED_STATUS))

clean_dangling :
ifneq "$(ALL_DANGLING)" ""
	$(COMMAND) rmi $(ALL_DANGLING))
endif

  # @echo $(ALL_INSTANCES)
  # @echo $(ALL_IMAGES)

clean_docker:
	$(COMMAND) stop $(ALL_INSTANCES)
	$(COMMAND) rm   $(ALL_INSTANCES)
	$(COMMAND) rmi  $(ALL_IMAGES)

#	$(COMMAND) build --no-cache=true -t $(APP_NAME) .
#	$(COMMAND) build --no-cache=true -t $(APP_NAME) .

run :
	$(COMMAND) run -p 1935:1935 -p 8080:80 $(APP_NAME)
