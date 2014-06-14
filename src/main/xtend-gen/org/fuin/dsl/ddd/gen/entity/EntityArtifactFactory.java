package org.fuin.dsl.ddd.gen.entity;

import java.util.List;
import java.util.Map;
import java.util.Set;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Aggregate;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Constructor;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Entity;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace;
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Variable;
import org.fuin.dsl.ddd.gen.base.AbstractSource;
import org.fuin.dsl.ddd.gen.base.SrcImports;
import org.fuin.dsl.ddd.gen.base.SrcThrowsExceptions;
import org.fuin.dsl.ddd.gen.base.Utils;
import org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions;
import org.fuin.dsl.ddd.gen.extensions.ConstructorExtensions;
import org.fuin.dsl.ddd.gen.extensions.StringExtensions;
import org.fuin.dsl.ddd.gen.extensions.VariableExtensions;
import org.fuin.srcgen4j.commons.GenerateException;
import org.fuin.srcgen4j.commons.GeneratedArtifact;
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry;
import org.fuin.srcgen4j.core.emf.CodeSnippetContext;
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext;

@SuppressWarnings("all")
public class EntityArtifactFactory extends AbstractSource<Entity> {
  public Class<? extends Entity> getModelType() {
    return Entity.class;
  }
  
  public GeneratedArtifact create(final Entity entity, final Map<String,Object> context, final boolean preparationRun) throws GenerateException {
    try {
      final String className = entity.getName();
      EObject _eContainer = entity.eContainer();
      final Namespace ns = ((Namespace) _eContainer);
      final String pkg = this.asPackage(ns);
      String _name = entity.getName();
      final String fqn = ((pkg + ".") + _name);
      String _replace = fqn.replace(".", "/");
      final String filename = (_replace + ".java");
      final CodeReferenceRegistry refReg = Utils.getCodeReferenceRegistry(context);
      String _uniqueName = AbstractElementExtensions.uniqueName(entity);
      refReg.putReference(_uniqueName, fqn);
      if (preparationRun) {
        return null;
      }
      final SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext();
      this.addImports(ctx);
      this.addReferences(ctx, entity);
      ctx.resolve(refReg);
      String _artifactName = this.getArtifactName();
      CharSequence _create = this.create(ctx, entity, pkg, className);
      String _string = _create.toString();
      byte[] _bytes = _string.getBytes("UTF-8");
      return new GeneratedArtifact(_artifactName, filename, _bytes);
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public Object addImports(final CodeSnippetContext ctx) {
    return null;
  }
  
  public void addReferences(final CodeSnippetContext ctx, final Entity entity) {
    String _uniqueAbstractName = AbstractElementExtensions.uniqueAbstractName(entity);
    ctx.requiresReference(_uniqueAbstractName);
  }
  
  public CharSequence create(final SimpleCodeSnippetContext ctx, final Entity entity, final String pkg, final String className) {
    CharSequence _xblockexpression = null;
    {
      StringConcatenation _builder = new StringConcatenation();
      CharSequence __typeDoc = this._typeDoc(entity);
      _builder.append(__typeDoc, "");
      _builder.newLineIfNotEmpty();
      _builder.append("public final class ");
      String _name = entity.getName();
      _builder.append(_name, "");
      _builder.append(" extends Abstract");
      String _name_1 = entity.getName();
      _builder.append(_name_1, "");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      EList<Constructor> _constructors = entity.getConstructors();
      CharSequence __constructorsDecl = this._constructorsDecl(ctx, entity, _constructors);
      _builder.append(__constructorsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      CharSequence __childEntityLocatorMethods = this._childEntityLocatorMethods(entity);
      _builder.append(__childEntityLocatorMethods, "\t");
      _builder.newLineIfNotEmpty();
      _builder.append("\t");
      _builder.newLine();
      _builder.append("\t");
      CharSequence __methodsDecl = this._methodsDecl(ctx, entity);
      _builder.append(__methodsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("\t");
      CharSequence __eventMethodsDecl = this._eventMethodsDecl(entity);
      _builder.append(__eventMethodsDecl, "\t");
      _builder.newLineIfNotEmpty();
      _builder.newLine();
      _builder.append("}");
      _builder.newLine();
      final String src = _builder.toString();
      StringConcatenation _builder_1 = new StringConcatenation();
      String _copyrightHeader = this.getCopyrightHeader();
      _builder_1.append(_copyrightHeader, "");
      _builder_1.append(" ");
      _builder_1.newLineIfNotEmpty();
      _builder_1.append("package ");
      _builder_1.append(pkg, "");
      _builder_1.append(";");
      _builder_1.newLineIfNotEmpty();
      _builder_1.newLine();
      Set<String> _imports = ctx.getImports();
      SrcImports _srcImports = new SrcImports(_imports);
      _builder_1.append(_srcImports, "");
      _builder_1.newLineIfNotEmpty();
      _builder_1.newLine();
      _builder_1.append(src, "");
      _builder_1.newLineIfNotEmpty();
      _xblockexpression = _builder_1;
    }
    return _xblockexpression;
  }
  
  public CharSequence _constructorsDecl(final CodeSnippetContext ctx, final Entity entity, final List<Constructor> constructors) {
    StringConcatenation _builder = new StringConcatenation();
    {
      for(final Constructor constructor : constructors) {
        CharSequence __constructorDecl = this._constructorDecl(ctx, entity, constructor);
        _builder.append(__constructorDecl, "");
        _builder.newLineIfNotEmpty();
        _builder.newLine();
      }
    }
    return _builder;
  }
  
  public CharSequence _constructorDecl(final CodeSnippetContext ctx, final Entity entity, final Constructor constructor) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("/**");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* ");
    String _doc = constructor.getDoc();
    String _text = StringExtensions.text(_doc);
    _builder.append(_text, " ");
    _builder.newLineIfNotEmpty();
    _builder.append(" ");
    _builder.append("*");
    _builder.newLine();
    _builder.append(" ");
    _builder.append("* @param rootAggregate The root aggregate of this entity.");
    _builder.newLine();
    {
      EList<Variable> _variables = constructor.getVariables();
      for(final Variable v : _variables) {
        _builder.append("* @param ");
        String _name = v.getName();
        _builder.append(_name, "");
        _builder.append(" ");
        String _superDoc = VariableExtensions.superDoc(v);
        _builder.append(_superDoc, "");
        _builder.append(" ");
        _builder.newLineIfNotEmpty();
      }
    }
    _builder.append(" ");
    _builder.append("*/");
    _builder.newLine();
    _builder.append("public ");
    String _name_1 = entity.getName();
    _builder.append(_name_1, "");
    _builder.append("(final ");
    Aggregate _root = entity.getRoot();
    String _name_2 = _root.getName();
    _builder.append(_name_2, "");
    _builder.append(" rootAggregate, ");
    EList<Variable> _variables_1 = constructor.getVariables();
    CharSequence __paramsDecl = this._paramsDecl(_variables_1);
    _builder.append(__paramsDecl, "");
    _builder.append(") ");
    List<org.fuin.dsl.ddd.domainDrivenDesignDsl.Exception> _allExceptions = ConstructorExtensions.allExceptions(constructor);
    SrcThrowsExceptions _srcThrowsExceptions = new SrcThrowsExceptions(ctx, _allExceptions);
    _builder.append(_srcThrowsExceptions, "");
    _builder.append("{");
    _builder.newLineIfNotEmpty();
    _builder.append("\t");
    EList<Variable> _variables_2 = constructor.getVariables();
    String __superCall = this._superCall(_variables_2);
    _builder.append(__superCall, "\t");
    _builder.append("\t");
    _builder.newLineIfNotEmpty();
    _builder.append("}");
    _builder.newLine();
    return _builder;
  }
  
  public String _superCall(final List<Variable> vars) {
    int _size = vars.size();
    boolean _equals = (_size == 0);
    if (_equals) {
      return "super(rootAggregate);";
    } else {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("super(rootAggregate, ");
      {
        boolean _hasElements = false;
        for(final Variable v : vars) {
          if (!_hasElements) {
            _hasElements = true;
          } else {
            _builder.appendImmediate(", ", "");
          }
          String _name = v.getName();
          _builder.append(_name, "");
        }
      }
      _builder.append(");");
      return _builder.toString();
    }
  }
}
