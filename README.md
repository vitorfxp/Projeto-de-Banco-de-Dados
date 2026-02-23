# Projeto-de-Banco-de-Dados
''' TEMA: Clínica Veterinária
    OBJETIVO GERAL: Tratar de animais domésticos e venda de produtos
    Estrutura inicial do projeto:   Pastas: Clientes/Veterinários/Produtos/Tratamento'''
    
    
erDiagram
    CLIENTE ||--o{ ANIMAL : possui
    ANIMAL||--o{ ATENDENTE : recebe
    ATENDENTE ||--o{ VENDA : realiza
    VENDA ||--o{ PRODUTO : tipo
    VENDA ||--o{ SERVIÇO : tipo 
    SERVIÇO ||--|{ VETERINARIO : atende
    SERVIÇO ||--|{ TOSADOR : atende
    VETERINARIO ||--o{ CLIENTE : vira
    ATENDENTE ||--o{ CLIENTE : vira
    TOSADOR ||--o{ CLIENTE : vira
    TOSADOR{
        string id
        string nome
        string CPF
    }
    SERVIÇO{
        string tipo
        float preço
    }
    VENDA{
        string id
        date orderDate
        string status
    }
    ATENDENTE {
        string id
        string name
        string CPF
        }
    ANIMAL {
        string id
        string name
        string email
    } 
    CLIENTE {
        string id
        string nome
        string CPF
    }
    VETERINARIO {
        string id
        string nome
        string CPF
    }
    PRODUTO {
        string id
        string nome
        float preço
        int quantidade
    }

<img width="4063" height="7573" alt="Client-Driven Animal Care-2026-02-23-231444" src="https://github.com/user-attachments/assets/8ac18107-d976-46ed-b507-a57218dedc32" />

    
