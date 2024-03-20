FROM python:3.10

RUN cat /dev/null > /etc/apt/sources.list
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

RUN git clone https://github.com/Eng-Elias/CrewAI-Visualizer.git
RUN cd CrewAI-Visualizer
RUN npm install

RUN python -m venv venv
RUN source venv/bin/activate

WORKDIR /CrewAI-Visualizer

COPY ./entrypoint.sh /CrewAI-Visualizer/entrypoint.sh

COPY ./requirements.txt /CrewAI-Visualizer/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /CrewAI-Visualizer/requirements.txt

COPY . .

RUN chmod +x /CrewAI-Visualizer/entrypoint.sh
ENTRYPOINT ["sh", "/CrewAI-Visualizer/entrypoint.sh"]

EXPOSE 8081
