# Projeto-de-Banco-de-Dados
''' TEMA: Clínica Veterinária
    OBJETIVO GERAL: Tratar de animais domésticos e venda de produtos
    Estrutura inicial do projeto:   Pastas: Clientes/Veterinários/Produtos/Tratamento'''
    
    

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
