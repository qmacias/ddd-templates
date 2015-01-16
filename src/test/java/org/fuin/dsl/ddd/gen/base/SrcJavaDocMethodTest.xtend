package org.fuin.dsl.ddd.gen.base

import javax.inject.Inject
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.fuin.dsl.ddd.DomainDrivenDesignDslInjectorProvider
import org.fuin.dsl.ddd.domainDrivenDesignDsl.DomainModel
import org.fuin.dsl.ddd.domainDrivenDesignDsl.ValueObject
import org.fuin.srcgen4j.core.emf.SimpleCodeReferenceRegistry
import org.fuin.srcgen4j.core.emf.SimpleCodeSnippetContext
import org.junit.Test
import org.junit.runner.RunWith

import static org.fest.assertions.Assertions.*

import static extension org.fuin.dsl.ddd.extensions.DddDomainModelExtensions.*

@InjectWith(typeof(DomainDrivenDesignDslInjectorProvider))
@RunWith(typeof(XtextRunner))
class SrcJavaDocMethodTest {

	@Inject
	private ParseHelper<DomainModel> parser

	@Inject 
	private ValidationTestHelper validationTester

	@Test
	def void testCreate() {

		// PREPARE
		val refReg = new SimpleCodeReferenceRegistry()
		val ctx = new SimpleCodeSnippetContext(refReg)

		val ValueObject valueObject = createModel().find(ValueObject, "MyValueObject")
		val method = valueObject.methods.get(0)
		val SrcJavaDocMethod testee = new SrcJavaDocMethod(ctx, method)

		// TEST
		val result = testee.toString

		// VERIFY
		assertThat(result).isEqualTo(
			'''
				/**
				 * This method does cool things.
				 *
				 * @param a Abc.
				 * @param b Def.
				 *
				 * @throws WhateverException Argh...
				 */
			''')
		assertThat(ctx.imports).isEmpty()

	}

	private def DomainModel createModel() {
		val DomainModel model = parser.parse(
			'''
				context a {
					
					namespace b {
						
						type String
						type Integer
				
						value-object MyValueObject {
				
							/**
							 * This method does cool things.
							 */
							method whatever business-rules WhateverConstraint {
								
								/** Abc. */
								String a
								
								/** Def. */
								Integer b
								
							}
				
						}
				
						/** Makes sure that this is compliant. */
						constraint WhateverConstraint exception WhateverException {
							message "WhateverConstraint message"
						}
				
						/** Argh... */
						exception WhateverException {
							message "WhateverException message"
						}		
				
					}
				
				}
			''')
			validationTester.assertNoIssues(model)
			return model		
	}

}
