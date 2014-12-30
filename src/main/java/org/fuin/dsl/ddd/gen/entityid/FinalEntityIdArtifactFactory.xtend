package org.fuin.dsl.ddd.gen.entityid

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.EntityId
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcJavaDoc
import org.fuin.dsl.ddd.gen.base.SrcVoBaseMethods
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.AbstractVOExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class FinalEntityIdArtifactFactory extends AbstractSource<EntityId> {

	override getModelType() {
		typeof(EntityId)
	}

	override create(EntityId entityId, Map<String, Object> context, boolean preparationRun) throws GenerateException {

		val className = entityId.name
		val abstractClassName = entityId.abstractName
		val Namespace ns = entityId.namespace;
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(entityId.uniqueName, fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(entityId)

		return new GeneratedArtifact(artifactName, filename,
			create(ctx, entityId, pkg, className, abstractClassName).toString().getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")
		ctx.requiresImport("org.fuin.objects4j.common.Immutable")
	}

	def addReferences(CodeSnippetContext ctx, EntityId entityId) {
		ctx.requiresReference(entityId.uniqueName + "Converter")
		ctx.requiresReference(entityId.uniqueAbstractName)
	}

	def create(SimpleCodeSnippetContext ctx, EntityId id, String pkg, String className, String abstractClassName) {
		val String src = ''' 
			«new SrcJavaDoc(id)»
			@Immutable
			@XmlJavaTypeAdapter(«id.name»Converter.class)
			public final class «className» extends «abstractClassName» {
			
				private static final long serialVersionUID = 1000L;
				
				@Override
				public final «id.baseTypeName» asBaseType() {
					return getValue();
				}
				
				@Override
				public final String asString() {
					return "" + getValue();
				}
				
				«new SrcVoBaseMethods(ctx, id)»
				
			}
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
