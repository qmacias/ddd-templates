package org.fuin.dsl.ddd.gen.valueobject;

import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.srcgen4j.commons.ArtifactFactory;
import org.fuin.srcgen4j.commons.ArtifactFactoryConfig;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;

@SuppressWarnings("all")
public class AbstractValueObjectArtifactFactory extends AbstractSource implements ArtifactFactory<ValueObject> {
  private String artifactName;
  
  public Class<? extends ValueObject> getModelType() {
    return ValueObject.class;
  }
  
  public void init(final ArtifactFactoryConfig config) {
    String _artifact = config.getArtifact();
    this.artifactName = _artifact;
  }
  
  public boolean isIncremental() {
    return true;
  }
  
  public GeneratedArtifact create(final ValueObject valueObject) throws GenerateException {
    EObject _eContainer = valueObject.eContainer();
    final Namespace ns = ((Namespace) _eContainer);
    String _name = ns.getName();
    String _plus = (_name + ".Abstract");
    String _name_1 = valueObject.getName();
    String _plus_1 = (_plus + _name_1);
    String _replace = _plus_1.replace(".", "/");
    final String filename = (_replace + ".java");
    CharSequence _create = this.create(valueObject, ns);
    String _string = _create.toString();
    GeneratedArtifact _generatedArtifact = new GeneratedArtifact(this.artifactName, filename, _string);
    return _generatedArtifact;
  }
  
  public CharSequence create(final ValueObject vo, final Namespace ns) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("package ");
    String _name = ns.getName();
    _builder.append(_name, "");
    _builder.append(";");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    CharSequence __imports = this._imports(vo);
    _builder.append(__imports, "");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("/** ");
    String _doc = vo.getDoc();
    String _text = this.text(_doc);
    _builder.append(_text, "");
    _builder.append(" */");
    _builder.newLineIfNotEmpty();
    _builder.append("public abstract class Abstract");
    String _name_1 = vo.getName();
    _builder.append(_name_1, "");
    _builder.append(" {");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    EList<Variable> _variables = vo.getVariables();
    CharSequence __varsDecl = this._varsDecl(_variables);
    _builder.append(__varsDecl, "	");
    _builder.newLineIfNotEmpty();
    _builder.newLine();
    _builder.append("\t");
    _builder.append("public Abstract");
    String _name_2 = vo.getName();
    _builder.append(_name_2, "	");
    _builder.append("(");
    EList<Variable> _variables_1 = vo.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables_1);
    _builder.append(__paramsDecl, "	");
    _builder.append(") {");
    _builder.newLineIfNotEmpty();
    _builder.append("\t\t");
    _builder.append("super();");
    _builder.newLine();
    _builder.append("\t\t");
    EList<Variable> _variables_2 = vo.getVariables();
    CharSequence __paramsAssignment = this._paramsAssignment(_variables_2);
    _builder.append(__paramsAssignment, "		");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    _builder.append("}");
    _builder.newLine();
    _builder.append("\t");
    _builder.newLine();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
}
