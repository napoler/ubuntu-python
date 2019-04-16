FROM ubuntu

#更换国内源
# RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt-get clean && apt-get update
RUN apt-get install -y git python3 build-essential libssl-dev libffi-dev python3-pip python3-dev
# libasound-dev portaudio portaudio-dev
# RUN apt-get install -y python3-pyaudio

RUN mkdir /root/.pip/
RUN echo "[global]">>/root/.pip/pip.conf 
RUN echo "index-url = https://pypi.tuna.tsinghua.edu.cn/simple">>/root/.pip/pip.conf 
RUN echo "[install]">>/root/.pip/pip.conf 
RUN echo "trusted-host=mirrors.aliyun.com">>/root/.pip/pip.conf 

# 安装常用科学库
RUN pip3 install numpy scipy pandas matplotlib 
# # 安装pyaudio
RUN apt-get install -y python3-pyaudio && pip3 install pyaudio



VOLUME /myapp

# # EXPOSE 27017 28017

    
# #使用国内pip加速
# RUN pip install pip -U
# RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

ADD . /myapp
# #RUN git clone https://github.com/t-web/alpine_terry_python_flask.git /myapp
WORKDIR /myapp



#安装一个生成依赖的库
RUN pip3  install pipreqs

#安装依赖
# RUN pip3 install -r requirements.txt
# RUN pipreqs ./

# # RUN  rm -rf /myapp/11* 
EXPOSE 5000
# #CMD myapp --port 8000
# #CMD ["python3", "app.py"]

# #修改全局变量
RUN echo "PYTHONPATH=$HOME/myapp/:$PYTHONPATH">>/etc/environment 
# #开启调试模式
RUN echo "FLASK_ENV=development">>/etc/environment 
# RUN export PYTHONPATH=$HOME/myapp/:$PYTHONPATH

# #开启debug
# # RUN export FLASK_APP=app.py
# # # RUN export FLASK_DEBUG=1 
# # RUN export FLASK_ENV=development


#清理旧版本的软件缓存
RUN apt-get -y autoclean && apt-get -y clean && apt-get -y autoremove      
　







# # ENTRYPOINT [ "/myapp/tool/mongo.sh" ]
# # CMD [ "mongod", "--bind_ip", "0.0.0.0" ]


# #&& python -m flask run 
# # CMD ["flask", "run", "--port=8110", "--no-browser", \
# #     "--allow-root", "--host=0.0.0.0"]


# # CMD ["python", "app.py", "--port=8110", "--no-browser", \
# #     "--allow-root", "--ip=0.0.0.0", "--NotebookApp.token="]

# #python3 -m flask run --host=0.0.0.0