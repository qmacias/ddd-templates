package org.fuin.dsl.ddd.gen.event

import java.util.Map
import org.fuin.dsl.ddd.domainDrivenDesignDsl.AbstractEntity
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Event
import org.fuin.dsl.ddd.domainDrivenDesignDsl.Namespace
import org.fuin.dsl.ddd.gen.base.AbstractSource
import org.fuin.dsl.ddd.gen.base.SrcAll
import org.fuin.dsl.ddd.gen.base.SrcInvokeMethod
import org.fuin.srcgen4j.commons.GenerateException
import org.fuin.srcgen4j.commons.GeneratedArtifact
import org.fuin.srcgen4j.core.emf.CodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.CodeSnippetContext
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext

import static org.fuin.dsl.ddd.gen.base.Utils.*

import static extension org.fuin.dsl.ddd.gen.extensions.AbstractElementExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.CollectionExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EObjectExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.EventExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.VariableExtensions.*
import static extension org.fuin.dsl.ddd.gen.extensions.MapExtensions.*

class EventTestArtifactFactory extends AbstractSource<Event> {

	override getModelType() {
		typeof(Event)
	}

	override create(Event event, Map<String, Object> context, boolean preparationRun) throws GenerateException {
		val AbstractEntity entity = event.entity;
		val className = event.getName() + "Test"
		var Namespace ns;
		if (entity == null) {
			ns = event.namespace;
		} else {
			ns = entity.namespace;		
		}
		val pkg = ns.asPackage
		val fqn = pkg + "." + className
		val filename = fqn.replace('.', '/') + ".java";

		val CodeReferenceRegistry refReg = context.codeReferenceRegistry
		refReg.putReference(event.uniqueName + "Test", fqn)

		if (preparationRun) {

			// No code generation during preparation phase
			return null
		}

		val SimpleCodeSnippetContext ctx = new SimpleCodeSnippetContext(refReg)
		ctx.addImports
		ctx.addReferences(event)

		var String src;
		if (entity == null) {
			src = createStandardEventTest(ctx, event, pkg, className).toString();
		} else {
			src = createDomainEventTest(ctx, event, pkg, className).toString();		
		}

		return new GeneratedArtifact(artifactName, filename, src.getBytes("UTF-8"));
	}

	def addImports(CodeSnippetContext ctx) {
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter")
		ctx.requiresImport("static org.fest.assertions.Assertions.*")
		ctx.requiresImport("org.junit.Test")
		ctx.requiresImport("javax.xml.bind.annotation.adapters.XmlAdapter")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPathConverter")
		ctx.requiresImport("org.fuin.ddd4j.ddd.EntityIdPath")
		ctx.requiresImport("static org.fuin.units4j.Units4JUtils.serialize")
		ctx.requiresImport("static org.fuin.units4j.Units4JUtils.deserialize")
		ctx.requiresImport("static org.fuin.units4j.Units4JUtils.marshal")
		ctx.requiresImport("static org.fuin.units4j.Units4JUtils.unmarshal")
	}

	def addReferences(CodeSnippetContext ctx, Event event) {
		ctx.requiresReference(event.uniqueName)
		if (event.entity != null) {
			ctx.requiresReference(event.aggregate.idType.uniqueName)		
	    	ctx.requiresReference(event.context.name.toFirstUpper + "EntityIdFactory")
		}
	    for (v : event.variables.nullSafe) {
			ctx.requiresReference(v.type.uniqueName)
			if (v.multiplicity != null) {
				ctx.requiresImport("java.util.List")
			}
	    }
	}

	def createDomainEventTest(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			// CHECKSTYLE:OFF
			public final class «event.name»Test {
			
				@Test
				public final void testSerializeDeserialize() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final «event.name» copy = deserialize(serialize(original));
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
			
				}
			
				@Test
				public final void testMarshalUnmarshal() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final String xml = marshal(original, createAdapter(), «event.name».class);
					final «event.name» copy = unmarshal(xml, createAdapter(), «event.name».class);
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
			
				}
			
				private «event.name» createTestee() {
					// TODO Set test values
				    final «event.aggregate.idType.name» entityId = null;
					«FOR v : event.variables.nullSafe»
					final «v.type(ctx)» «v.name» = null;
					«ENDFOR»
					return new «new SrcInvokeMethod(ctx, event.name, union("new EntityIdPath(entityId)", event.variables.varNames))»
				}
			
			    protected final XmlAdapter<?, ?>[] createAdapter() {
			        final EntityIdPathConverter entityIdPathConverter = new EntityIdPathConverter(new «event.context.name.toFirstUpper»EntityIdFactory());
			        return new XmlAdapter[] { entityIdPathConverter };
			    }
			
			}
			// CHECKSTYLE:ON
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

	def createStandardEventTest(SimpleCodeSnippetContext ctx, Event event, String pkg, String className) {
		val String src = ''' 
			// CHECKSTYLE:OFF
			public final class «event.name»Test {
			
				@Test
				public final void testSerializeDeserialize() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final «event.name» copy = deserialize(serialize(original));
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
			
				}
			
				@Test
				public final void testMarshalUnmarshal() {
			
					// PREPARE
					final «event.name» original = createTestee();
			
					// TEST
					final String xml = marshal(original, createAdapter(), «event.name».class);
					final «event.name» copy = unmarshal(xml, createAdapter(), «event.name».class);
			
					// VERIFY
					assertThat(original).isEqualTo(copy);
			
				}
			
				private «event.name» createTestee() {
					// TODO Set test values
					«FOR v : event.variables.nullSafe»
					final «v.type(ctx)» «v.name» = null;
					«ENDFOR»
					return new «new SrcInvokeMethod(ctx, event.name, event.variables.varNames)»
				}
			
			    protected final XmlAdapter<?, ?>[] createAdapter() {
			        return new XmlAdapter[] { };
			    }
			
			}
			// CHECKSTYLE:ON
		'''

		new SrcAll(copyrightHeader, pkg, ctx.imports, src).toString

	}

}
