

CC =F:\\MentorGraphics\\Sourcery_CodeBench_Lite_for_ARM_GNU_Linux\\bin\\arm-none-linux-gnueabi-gcc
CC =arm-linux-gnueabi-gcc
CFLAGS = -c -O2 

LD_FLAGS = -ldsi_netctrl \
    -lqdi \
    -lqmi_client_helper \
    -lqmi -lqmiservices -lqmi_client_qmux -lqmiidl \
    -lqmi_csi -lqmi_common_so -lqmi_cci -lqmi_sap -lqmi_encdec \
    -lnetmgr -lrmnetctl -ldiag -lconfigdb -lxml -ldsutils \
    -ltime_genoff -lgthread-2.0 -lglib-2.0

MAIN_DIR = .

TARGET_BIN_DIR = $(MAIN_DIR)/bin
TARGET_OBJ_DIR = $(MAIN_DIR)/obj

BIN_NAME  = demo_data_call

TEST_DIR = $(MAIN_DIR)

SRC_DIR = $(TEST_DIR) 

INCLUDE_PREFIX = -I

LINK_PREFIX = -L

ALL_PATHS = $(SRC_DIR)
ALL_PATHS += ./include/qmi-framework
ALL_PATHS += ./include/qmi
ALL_PATHS += ./include/data

ALL_INCLUDES = $(addprefix $(INCLUDE_PREFIX), $(ALL_PATHS))


ALL_LINKS = $(addprefix $(LINK_PREFIX), ./simcomlib)

OBJ_CMD = -o 

LD_CMD = -o

TEST_OBJS = $(TARGET_OBJ_DIR)/demo_data_call.o \
	    
			   
BIN_OBJS = $(TEST_OBJS) 

$(TARGET_OBJ_DIR)/%.o:$(TEST_DIR)/%.c 
	@echo ---------------------------------------------------------
	@echo $(ALL_PATHS)
	@echo $(ALL_INCLUDES)
	@echo Build OBJECT $(@) from SOURCE $<
	$(CC) $(CFLAGS) $(LD_FLAGS) $(ALL_INCLUDES) $(OBJ_CMD) $@ $<
	@echo ---------------------------------------------------------

.PHONY: all clean

all:prep bin 

prep:
	@if test ! -d $(TARGET_BIN_DIR); then mkdir $(TARGET_BIN_DIR); fi
	@if test ! -d $(TARGET_OBJ_DIR); then mkdir $(TARGET_OBJ_DIR); fi

bin:$(BIN_OBJS)
	@echo ---------------------------------------------------------
	@echo $(ALL_LINKS)
	@echo Create bin file $(BIN_NAME)
	$(CC) $(ALL_LINKS) $(ALL_INCLUDES) -lpthread $(LD_CMD)  $(TARGET_BIN_DIR)/$(BIN_NAME) $^ $(LD_FLAGS)
	@echo ---------------------------------------------------------
	
clean:
	@rm -fr $(TARGET_OBJ_DIR) $(TARGET_BIN_DIR) 
	
