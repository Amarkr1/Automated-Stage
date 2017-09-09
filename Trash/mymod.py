# mymod.py
"""Python module demonstrates passing MATLAB types to Python functions"""
import numpy
import visa
import CorvusEco
class MyClass():
	def search(words):
		"""Return list of words containing 'lo'"""
		newlist = [w for w in words if 'lo' in w]
		return newlist

	def theend(words):
		"""Append 'The End' to list of words"""
		words.append('The End')
		return words

	def sumTwo(a,b):
		sum = a+b
		return sum
	def display():
		stage = CorvusEco.CorvusEcoClass()
		par1 = 'ASRL7::INSTR'
		par2 = 2
		stage.connect(par1,par2)
		print stage
		type(stage)
		#return stage
		return 'Just a new message'