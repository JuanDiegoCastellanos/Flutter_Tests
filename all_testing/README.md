# Testing in Flutter

## Testing

**What is testing? :**

- Ensuring your app what does exactly what it should (Garantizar que la aplicación haga exactamente lo que debe hacer)
- Testing for regressions.

>> (Se introduce en la aplicación una nueva funcionalidad o se expanden algunas y el código ya está escrito, entonces allí pueden ocurrir dos cosas, si se tiene el entorno de pruebas configurado se sabe dónde hay fallos, si no, se pueden saber probando la misma aplicación (mala práctica, muy desgastante) o el usuario reportará estos fallos, lo cuál será un caso más grave haciendo que la reputación de la empresa sea afectada y así desencadenando una serie de factores negativos).


- Two main types:

    - Manual
    - Automated

## Tests in Flutter

### Unit test:

**For all code beside th UI Widgets.**

(Se usa para todo el código aparte de los widgets).

**One set of units tests usually tests a single class.**

(Un set de test unitarios usualmente testean una sola clase).

Examples:

- ChangeNotifiers
- BusinessLogic

### Widget tests

**For testing a single widget**

### Integration tests

**For testing large parts of the app from the user perspective**

**UI flow test**

| |Unit |Widget |Integration|
|-|:-----------:|:-----------:|:-----------:|
|Confidence|Low|Higher|Highest|
|Maintenance cost|Low |Higher|Highest|
|Dependencies|Few|More|Most|
|Execution Speed|Quick|Quick|Slow|


