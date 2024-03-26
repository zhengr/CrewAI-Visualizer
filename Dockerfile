FROM python:3.10

RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && apt-get install -y nodejs

RUN git clone https://github.com/zhengr/CrewAI-Visualizer.git
RUN cd CrewAI-Visualizer

WORKDIR /CrewAI-Visualizer

RUN npm install

RUN python -m venv venv
RUN source venv/bin/activate

COPY ./entrypoint.sh /CrewAI-Visualizer/entrypoint.sh

COPY ./requirements.txt /CrewAI-Visualizer/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /CrewAI-Visualizer/requirements.txt

COPY . .

RUN chmod +x /CrewAI-Visualizer/entrypoint.sh
ENTRYPOINT ["sh", "/CrewAI-Visualizer/entrypoint.sh"]

EXPOSE 3000
