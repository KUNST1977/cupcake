import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:cupcake/helpers/cadastro_helper.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _registerHelper = RegisterHelper();

  void _resetFields() {
    _nomeController.text = "";
    _cpfController.text = "";
    _addressController.text = "";
    _phoneController.text = "";
    _emailController.text = "";
    _passController.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  Future<void> _saveRegister() async {
    if (_formKey.currentState!.validate()) {
      Register register = Register();
      register.name = _nomeController.text;
      register.cpf = _cpfController.text;
      register.address = _addressController.text;
      register.phone = _phoneController.text;
      register.email = _emailController.text;
      register.pass = _passController.text;

      await _registerHelper.saveContact(register);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Cadastro realizado com sucesso!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 3),
        ),
      );

      _resetFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Nome Completo";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cpfController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu CPF";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Endereço";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Endereço',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Celular";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                decoration: const InputDecoration(
                  labelText: 'Celular',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu E-mail";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Senha";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
