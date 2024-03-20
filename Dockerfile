FROM python:3.10

RUN git clone https://github.com/Eng-Elias/CrewAI-Visualizer.git
RUN cd CrewAI-Visualizer
RUN npm install
RUN wget https://github.com/zhengr/SmartSearch/releases/download/0.1.0/ui.zip && unzip ui.zip

WORKDIR /CrewAI-Visualizer

COPY ./entrypoint.sh /CrewAI-Visualizer/entrypoint.sh

COPY ./requirements.txt /CrewAI-Visualizer/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /CrewAI-Visualizer/requirements.txt

COPY . .

RUN chmod +x /CrewAI-Visualizer/entrypoint.sh
ENTRYPOINT ["sh", "/CrewAI-Visualizer/entrypoint.sh"]

EXPOSE 8081
