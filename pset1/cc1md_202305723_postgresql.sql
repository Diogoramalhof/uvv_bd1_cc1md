--Aluno_Diogo Fardim Ramalho
--Turma: CC1MD
--Garantir que não haja nenhum banco de dados igual dentro do postgres.
DROP DATABASE IF EXISTS uvv;
--Garantir que não haja nenhum schema igual dentro do postgres.
DROP SCHEMA IF EXISTS lojas CASCADE;
--Garantir que não haja nenhum usuário igual dentro do postgres.
DROP USER IF EXISTS diogofr;
--Criar um novo usuário dentro do postgresSQL, tendo esse usuário permissão de criar um banco de dados, criar uma role e ter uma senha criptografada.
CREATE USER diogofr WITH CREATEDB CREATEROLE  ENCRYPTED PASSWORD 'oloko09';
--Criar um Banco de dados dentro do SGBD postgreSQL.
CREATE DATABASE uvv WITH   
OWNER = diogofr  
TEMPLATE = template0   
ENCODING =  'UTF8' 
LC_COLLATE =  'pt_BR.UTF-8'  
LC_CTYPE = 'pt_BR.UTF-8'  
ALLOW_CONNECTIONS = true;
--Trocar o banco de dados para o banco de dados que criamos.
\c uvv
--Trocar de usuário para o usuário que criamos.
SET ROLE diogofr;
--Afim de armazenar todos os objetos que serão criados com a implementação do projeto lógico devemos criar um schema.
CREATE SCHEMA lojas
AUTHORIZATION diogofr;
--Conferir qual schema está configurado no banco de dados que está sendo utilizado;
SELECT CURRENT_SCHEMA();
--Caso o esqueema que estiver sendo utilizado não for lojas, deve-se utilizar o comando para alterar o schema, porém, antes disso basta conferir a ordem dos schemas que estão definidos.
SHOW SEARCH_PATH;--conferir a ordem dos schemas que estão definidos.
--Temos que alterar o search_path para alterar o caminho para onde os objetos serão encaminhados, deve ser 'lojas'.
SET SEARCH_PATH TO lojas, "$user", public;
--Confirmar que o search_path foi alterado.
SHOW SEARCH_PATH;
--Para que o comando não seja temporário devemos usar um comando que fique permanente para o schema que alteramos.
ALTER USER diogofr
SET SEARCH_PATH TO lojas, "$user", public;
--Para conferir que está tudo correto dê os comandos para confirmar qual schema está configurado e a ordem dos schemas que estão definidos.
SELECT CURRENT_SCHEMA();
SHOW SEARCH_PATH;
--Apartir de agora iremos partir para a criação das tabelas.
--Começando pela tabela de produtos.
CREATE TABLE lojas.produtos (
--Vamos agora preencher as tuplas correspondendo com a tabela produtos.
                produto_id NUMERIC(38) NOT NULL,
                --numeric, varchar,date, etc são os tipos de dados contidos nas tuplas.
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
--Agora faremos os comentários referentes a tabela lojas.produtos necessários.
COMMENT ON TABLE lojas.produtos IS 'Tabela dos produtos referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.produtos.
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Identificação do produto, sendo uma PK da tabela produtos';
COMMENT ON COLUMN lojas.produtos.nome IS 'Nome dos produtos';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Preço por unidade do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Detalhes presentes no produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Imagem que representa o produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Descrição dos diversos arquivos presentes na imagem';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Arquivo presente na iamgem';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Descrição dos caractéres presentes na imagem';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Data da última alteração feita na imagem';

--Agora vamos criar a tabela clientes.
CREATE TABLE lojas.clientes (
--Vamos agora preencher as tuplas correspondendo com a tabela clientes.
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
--Agora faremos os comentários referentes a tabela lojas.clientes necessários.
COMMENT ON TABLE lojas.clientes IS 'Tabela dos clientes referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.clientes.
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'PK da tabela clientes, que visa a identificação dos clientes';
COMMENT ON COLUMN lojas.clientes.email IS 'Email relacionado aos clientes';
COMMENT ON COLUMN lojas.clientes.nome IS 'Nome dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Telefone primário dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Telefone secundário dos clientes';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Telefone terciário dos clientes';

--Agora vamos criar a tabela lojas.
CREATE TABLE lojas.lojas (
--Vamos agora preencher as tuplas correspondendo com a tabela lojas
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);
				--Agora vamos criar uma restrição para a tabela lojas.lojas na coluna latitude, onde não pode inserir valores menores que -90 e maiores que 90.
				ALTER TABLE lojas.lojas 
				ADD CONSTRAINT lojas_latitude 
				CHECK (latitude <= 90 AND latitude >= -90);
				--Agora vamos criar uma restrição para a tabela lojas.lojas na coluna longitude, onde não pode inserir valores menores que -180 e maiores que 80.
				ALTER TABLE lojas.lojas 
				ADD CONSTRAINT lojas_longitude
				CHECK (longitude <= 180 AND longitude >= -180);
				
--Agora faremos os comentários referentes a tabela lojas.lojas necessários.
COMMENT ON TABLE lojas.lojas IS 'Tabela das lojas referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.lojas.
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identificação das lojas presentes no banco de dados, sendo está uma PK da tabela lojas';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereço web (URL) das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Endereço físico das lojas';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Distância que representa a distância latitudinal da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Distância que representa a distância longitudinal da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'Logo que representa a loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Representa a variedade de documentos presentes na logo';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Tipo de arquivo da logo';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Codificação de caracteres presentes na logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Data da última atualização da logo referente a loja';

--Agora vamos criar a tabela envios.
CREATE TABLE lojas.envios (
--Vamos agora preencher as tuplas correspondendo com a tabela envios.
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT envios_pk PRIMARY KEY (envio_id));
               
                --Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.envios e lojas.clientes.
                ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
				FOREIGN KEY (cliente_id)
				REFERENCES lojas.clientes (cliente_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
			
				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.envios e lojas.lojas.
				ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
				FOREIGN KEY (loja_id)
				REFERENCES lojas.lojas (loja_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
			
                --Agora vamos criar uma restrição da tabela lojas.envios na coluna status onde somente seja aceito inserir dados que sejam ( CRIADO, ENVIADO, TRANSITO e ENTREGUE)
                ALTER TABLE lojas.envios
                ADD CONSTRAINT status_envios
                CHECK(status IN ( 'CRIADO' , 'ENVIADO' , 'TRANSITO' , 'ENTREGUE'));

--Agora faremos os comentários referentes a tabela lojas.envios.
COMMENT ON TABLE lojas.envios IS 'Tabela dos envios referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.envios.
COMMENT ON COLUMN lojas.envios.envio_id IS 'Identificação dos envios sendo uma PK para a tabela envios';
COMMENT ON COLUMN lojas.envios.loja_id IS 'FK da tabela lojas';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Endereço para onde vai ser enviado o produto';
COMMENT ON COLUMN lojas.envios.status IS 'Status do envio do produto ( CRIADO, ENVIADO, TRANSITO e ENTREGUE.)';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'PK da tabela clientes, que visa a identificação dos clientes';

--Agora vamos criar a tabela estoque.
CREATE TABLE lojas.estoques (
--Vamos agora preencher as tuplas correspondendo com a tabela estoque.
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantitade NUMERIC(38) NOT NULL,
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)                
);
				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.estoque e lojas.lojas.
				ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
				FOREIGN KEY (loja_id)
				REFERENCES lojas.lojas (loja_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
			
				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.estoque e lojas.produtos.
				ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
				FOREIGN KEY (produto_id)
				REFERENCES lojas.produtos (produto_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
			
				--Agora vamos adicionar uma restrição na tabela lojas.estoques na coluna quantidade onde só possa inserir dados maiores que -1.
				ALTER TABLE lojas.estoques
				ADD CONSTRAINT estoques_quantidade
				CHECK( quantitade >-1);

--Agora faremos os comentários referentes as colunas referentes a tabela lojas.estoques.
COMMENT ON TABLE lojas.estoques IS 'Tabela dos estoques referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.estoques.
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Identificação do estoque, sendo está uma PK da tabela estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Identificação das lojas presentes no banco de dados,  sendo está uma FK da tabela lojas';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Identificação do produto,  sendo está uma FK da tabela produtos';
COMMENT ON COLUMN lojas.estoques.quantitade IS 'Quantidade presente de produtos no estoque';

--Agora vamos criar a tabela pedidos.
CREATE TABLE lojas.pedidos (
--Vamos agora preencher as tuplas correspondendo com a tabela pedidos.
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)

);
				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.pedidos e lojas.clientes.
				ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
                FOREIGN KEY (cliente_id)
				REFERENCES lojas.clientes (cliente_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
			
				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.pedidos e lojas.lojas.
				ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
				FOREIGN KEY (loja_id)
				REFERENCES lojas.lojas (loja_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
				
				 --Agora vamos criar uma restrição da tabela lojas.pedidos na coluna status onde somente seja aceito inserir dados que sejam ( CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO e ENVIADO)
				ALTER TABLE lojas.pedidos
				ADD CONSTRAINT status_pedidos CHECK (status IN  ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO' , 'ENVIADO'));

			
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.pedidos.
COMMENT ON TABLE lojas.pedidos IS 'Tabela dos pedidos referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.pedidos.
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Identificação do pedido, sendo uma PK da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Data e hora referente quando o pedido foi feito';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'PK da tabela clientes, que visa a identificação dos clientes, sendo uma FK para a tabela clientes';
COMMENT ON COLUMN lojas.pedidos.status IS 'Status do pedido que foi feito podendo ser (CRIADO, ENVIADO, TRANSITO e ENTREGUE.)';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Identificação das lojas presentes no banco de dados sendo uma FK da tabela lojas';

--Agora vamos criar a tabela pedidos_itens.
CREATE TABLE lojas.pedidos_itens (
--Vamos agora preencher as tuplas correspondendo com a tabela pedidos_itens.
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                --Agora devemos adicionar uma chave primária afim de promover Identificação única de registros, Integridade dos dados,Relacionamentos entre tabelas, dentre outros fatores positivos.
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.pedidos_itens e lojas.envios.
				ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
				FOREIGN KEY (envio_id)
				REFERENCES lojas.envios (envio_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
			
				--Agora vamos adicionar uma foreign key, afim de criarmos um relacionamento entre as tabelas lojas.pedidos_itens e lojas.pedidos.
				ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
				FOREIGN KEY (pedido_id)
				REFERENCES lojas.pedidos (pedido_id)
				ON DELETE NO ACTION
				ON UPDATE NO ACTION
				NOT DEFERRABLE;
				
				 --Agora vamos criar uma restrição da tabela lojas.pedidos_itens na coluna preco_unitario onde só podem inserir dados maiores que 0.
				ALTER TABLE lojas.pedidos_itens
				ADD CONSTRAINT preco_unitario_pedidos_itens
				CHECK (preco_unitario > 0);
			
				--Agora vamos criar uma restrição da tabela lojas.pedidos_itens na coluna quantidade onde só podem inserir dados maiores que 0.
				ALTER TABLE lojas.pedidos_itens
				ADD CONSTRAINT quantidade_pedidos_itens
				CHECK (quantidade > 0);
			
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.pedidos_itens
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela dos itens solicitados referentes ao banco de dados das lojas UVV';
--Agora faremos os comentários referentes as colunas referentes a tabela lojas.pedidos_itens.
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Identificação do pedido sendo está uma chave dupla';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Identificação do produto, sendo está uma chave dupla';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Numero da linha referente ao item que foi solicitado';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Preço unitário referente ao item que foi solicitado';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Quantidade que foi solicitada do item';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Identificação dos envios sendo está uma FK da tabela envios';



















